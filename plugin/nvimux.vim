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

" Commands
command! -nargs=0 NvimuxVerticalSplit vspl|wincmd l|enew
command! -nargs=0 NvimuxHorizontalSplit spl|wincmd j|enew
command! -nargs=0 NvimuxTermPaste call s:term_only("normal pa")
command! -nargs=0 NvimuxToggleTerm call Nvimux_toggle_term_func()

" Use neoterm
if exists('g:neoterm') && !exists('g:nvimux_no_neoterm')
  let s:nvimux_new_term='Tnew'
  let s:nvimux_close_term='Tclose'
  let s:nvimux_toggle_term='Ttoggle'
else
  let s:nvimux_last_buffer_id = 0

  call s:defn('g:nvimux_toggle_direction', 'botright')
  call s:defn('g:nvimux_toggle_orientation', 'vertical')
  call s:defn('g:nvimux_toggle_size', '')

  let s:nvimux_split_type = g:nvimux_toggle_direction.' '.g:nvimux_toggle_orientation.' '.g:nvimux_toggle_size.'split'

  function! s:nvimux_new_toggle_term() abort
    exec s:nvimux_split_type." | terminal"
    set wfw
    let s:nvimux_last_buffer_id = bufnr('%')
  endfunction

  function! Nvimux_toggle_term_func() abort
    if !s:nvimux_last_buffer_id
      call s:nvimux_new_toggle_term()
    else
      let wbuff = bufwinnr(s:nvimux_last_buffer_id)
      if wbuff == -1
        if bufname(s:nvimux_last_buffer_id) == ""
          call s:nvimux_new_toggle_term()
        else
          exec s:nvimux_split_type." | ".'b'.s:nvimux_last_buffer_id
          set wfw
        endif
      else
        exec wbuff.' wincmd w'
        q
      endif
    endif
  endfunction

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
  call s:nvimux_bind_key('x', ':'.s:nvimux_close_term.'<CR>', ['t'])

  if exists("g:nvimux_custom_bindings")
    for b in g:nvimux_custom_bindings
      call s:nvimux_raw_bind(b[0], b[1], b[2])
    endfor
  endif
endif
