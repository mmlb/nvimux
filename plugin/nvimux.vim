if !exists('g:nvimux_prefix')
  let g:nvimux_prefix='<C-b>'
endif

if !exists('g:nvimux_terminal_quit')
  let g:nvimux_terminal_quit='<C-\><C-n>'
endif

" Use neoterm
if exists('g:neoterm') && !exists('g:nvimux_no_neoterm')
  let s:nvimux_new_term='Tnew'
  let s:nvimux_close_term='Tclose'
  let s:nvimux_toggle_term='Ttoggle'
else
  let s:nvimux_last_buffer_id = 0

  if !exists('g:nvimux_toggle_direction')
    let g:nvimux_toggle_direction = 'botright'
  endif

  if !exists('g:nvimux_toggle_orientation')
    let g:nvimux_toggle_orientation = 'vertical'
  endif

  if !exists('g:nvimux_toggle_size')
    let g:nvimux_toggle_size = ''
  endif

  let s:nvimux_split_type = g:nvimux_toggle_direction.' '.g:nvimux_toggle_orientation.' '.g:nvimux_toggle_size.'split'

  function! Nvimux_toggle_term_func() abort
    if !s:nvimux_last_buffer_id
      exec s:nvimux_split_type." | terminal"
      let s:nvimux_last_buffer_id = bufnr('%')
    else
      let wbuff = bufwinnr(s:nvimux_last_buffer_id)
      if wbuff == -1
        exec s:nvimux_split_type." | ".'b'.s:nvimux_last_buffer_id
      else
        exec wbuff.' wincmd w'
        q
      endif
    endif
  endfunction

  let s:nvimux_new_term='term'
  let s:nvimux_close_term='x'
  let s:nvimux_toggle_term='call Nvimux_toggle_term_func()'
endif

function! s:nvimux_bind_key(k, v, modes) abort
  for m in a:modes
    if m == 't'
      let cmd = g:nvimux_terminal_quit.a:v
    elseif m == 'i'
      let cmd = '<ESC>'.a:v
    else
      let cmd = a:v
    endif
    exec m.'noremap '.g:nvimux_prefix.a:k." ".cmd
  endfor
endfunction


if !exists('$TMUX')

  if exists('g:nvimux_open_term_by_default')
    call s:nvimux_bind_key('c', ':tabe\|'.s:nvimux_new_term.'<CR>', ['n', 'v', 'i', 't'])
    call s:nvimux_bind_key('t', ':tabe<CR>', ['n', 'v', 'i', 't'])
  else
    call s:nvimux_bind_key('c', ':tabe<CR>', ['n', 'v', 'i', 't'])
  endif

  call s:nvimux_bind_key('<C-r>', ':so $MYVIMRC<CR>', ['n', 'v', 'i'])
  call s:nvimux_bind_key('!', ':tabe %<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('%', ':vspl<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('"', ':spl<CR>', ['n', 'v', 'i', 't'])
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

  call s:nvimux_bind_key('x', ':'.s:nvimux_close_term.'<CR>', ['t'])

  call s:nvimux_bind_key(']', 'pa', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('h', '<C-w><C-h>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('j', '<C-w><C-j>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('k', '<C-w><C-k>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('l', '<C-w><C-l>', ['n', 'v', 'i', 't'])

  call s:nvimux_bind_key(':', ':', ['t'])
  call s:nvimux_bind_key('[', '', ['t'])

  " TODO check if can force only on terminal buffer
  call s:nvimux_bind_key(']', 'pa', ['n', 'v', 'i'])
endif
