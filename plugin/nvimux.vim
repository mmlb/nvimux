" Private/Local functions
function! s:defn(var, val)
  if !exists(a:var)
    exec 'let '.a:var."='".a:val."'"
  endif
endfunction

function! s:term_only(cmd)
  if(&buftype == "terminal")
    exec a:cmd
  else
    echomsg "Not on terminal"
  endif
endfunction

call s:defn('g:nvimux_prefix', '<C-b>')
call s:defn('g:nvimux_terminal_quit', '<C-\><C-n>')
call s:defn('g:nvimux_vertical_split', ':NvimuxVerticalSplit<CR>')
call s:defn('g:nvimux_horizontal_split', ':NvimuxHorizontalSplit<CR>')
call s:defn('g:nvimux_quickterm_scope', 'g')

" Commands
command! -nargs=0 NvimuxVerticalSplit vspl|wincmd l|enew
command! -nargs=0 NvimuxHorizontalSplit spl|wincmd j|enew
command! -nargs=0 NvimuxTermPaste call s:term_only("normal pa")
command! -nargs=0 NvimuxToggleTerm call NvimuxToggleTermFunc()
command! -nargs=1 NvimuxTermRename call s:term_only("file term://<args>")

" Use neoterm
if exists('g:neoterm') && !exists('g:nvimux_no_neoterm')
  let s:nvimux_has_warned_deprecation = 0
  function! NvimuxDeprecatedToggle() abort
      if !s:nvimux_has_warned_deprecation
        let s:nvimux_has_warned_deprecation = 1
        echomsg "Nvimux: Neoterm support will be dropped in the future. Consider trying native terminal."
      endif
      Ttoggle
  endfunction
  let s:nvimux_new_term='Tnew'
  let s:nvimux_close_term='Tclose'
  let s:nvimux_toggle_term='call NvimuxDeprecatedToggle()'
else
  call s:defn('g:nvimux_toggle_direction', 'botright')
  call s:defn('g:nvimux_toggle_orientation', 'vertical')
  call s:defn('g:nvimux_toggle_size', '')

  let s:nvimux_split_type = g:nvimux_toggle_direction.' '.g:nvimux_toggle_orientation.' '.g:nvimux_toggle_size.'split'

  let s:nvimux_new_term='term'
  let s:nvimux_close_term='x'
  let s:nvimux_toggle_term='NvimuxToggleTerm'
endif

" Binding functions
function! s:nvimux_raw_bind(k, v, modes) abort
  for m in a:modes
    if m == 't'
      let cmd = g:nvimux_terminal_quit.a:v
    elseif m == 'i'
      let cmd = '<ESC>'.a:v
    else
      let cmd = a:v
    endif
    exec m.'noremap <silent> '.g:nvimux_prefix.a:k." ".cmd
  endfor
endfunction

function! s:nvimux_bind_key(k, v, modes) abort
  if exists("g:nvimux_override_".a:k)
    exec "let p_cmd = "g:nvimux_override_".a:k
    call s:nvimux_raw_bind(a:k, p_cmd, a:modes)
  else
    call s:nvimux_raw_bind(a:k, a:v, a:modes)
  endif
endfunction

function! s:nvimux_get_var_value(var_name) abort
  exec "let s:tmp = ".a:var_name
  return s:tmp
endfunction

function! s:nvimux_set_var_value(var_name, value) abort
  exec "let ".a:var_name." = ".a:value
endfunction

function! s:nvimux_new_toggle_term() abort
  exec s:nvimux_split_type." | terminal"
  set wfw
  let bufid = bufnr('%')
  if bufnr("Quickterm") == -1
    NvimuxTermRename Quickterm
  endif
  call setbufvar(bufid, 'nvimux_buf_orientation', s:nvimux_split_type)
  call s:nvimux_set_var_value(g:nvimux_quickterm_scope.":nvimux_last_buffer_id", bufid)
endfunction

" Public Functions
function! NvimuxRawToggle(backing_var, create_new) abort
  if !exists(a:backing_var) || ! s:nvimux_get_var_value(a:backing_var)
    exec a:create_new
  else
    let bufid = s:nvimux_get_var_value(a:backing_var)
    let wbuff = bufwinnr(bufid)
    if wbuff == -1
      if bufname(bufid) == ""
        exec a:create_new
      else
        exec getbufvar(bufid, 'nvimux_buf_orientation', s:nvimux_split_type)." | ".'b'.bufid
        set wfw
      endif
    else
      exec wbuff.' wincmd w'
      q
    endif
  endif
endfunction

function! NvimuxInteractiveTermRename() abort
  call inputsave()
  let term_name = input("nvimux > New term name: ")
  call inputrestore()
  redraw
  exec 'NvimuxTermRename '.term_name
endfunction

function! NvimuxToggleTermFunc() abort
  call NvimuxRawToggle(g:nvimux_quickterm_scope.":nvimux_last_buffer_id", "call s:nvimux_new_toggle_term()")
endfunction

" TMUX emulation itself
if !exists('$TMUX')

  if exists('g:nvimux_open_term_by_default')
    call s:nvimux_bind_key('c', ':tabe\|'.s:nvimux_new_term.'<CR>', ['n', 'v', 'i', 't'])
    call s:nvimux_bind_key('t', ':tabe<CR>', ['n', 'v', 'i', 't'])
  else
    call s:nvimux_bind_key('c', ':tabe<CR>', ['n', 'v', 'i', 't'])
  endif

  call s:nvimux_bind_key('<C-r>', ':so $MYVIMRC<CR>', ['n', 'v', 'i'])
  call s:nvimux_bind_key('!', ':tabe %<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('%', g:nvimux_vertical_split , ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('"', g:nvimux_horizontal_split, ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('q', ':'.s:nvimux_toggle_term.'<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('w', ':tabs<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('o', '<C-w>w', ['n', 'v', 'i', 't'])

  for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
    call s:nvimux_bind_key(i, i.'gt', ['n', 'v', 'i', 't'])
  endfor

  call s:nvimux_bind_key('n', 'gt', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('p', 'gT', ['n', 'v', 'i', 't'])

  call s:nvimux_bind_key('x', ':x<CR>', ['n', 'v', 'i'])
  call s:nvimux_bind_key('X', ':bd %<CR>', ['n', 'v', 'i'])

  call s:nvimux_bind_key('h', '<C-w><C-h>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('j', '<C-w><C-j>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('k', '<C-w><C-k>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('l', '<C-w><C-l>', ['n', 'v', 'i', 't'])

  " term specific stuff
  call s:nvimux_bind_key(':', ':', ['t'])
  call s:nvimux_bind_key('[', '', ['t'])
  call s:nvimux_bind_key(']', ':NvimuxTermPaste<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key(',', ':call NvimuxInteractiveTermRename()<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('x', ':'.s:nvimux_close_term.'<CR>', ['t'])

  if exists("g:nvimux_custom_bindings")
    for b in g:nvimux_custom_bindings
      call s:nvimux_raw_bind(b[0], b[1], b[2])
    endfor
  endif
endif
