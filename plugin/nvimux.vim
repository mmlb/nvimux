if !exists('g:nvimux_prefix')
  let g:nvimux_prefix='<C-b>'
endif

if !exists('g:nvimux_terminal_quit')
  let g:nvimux_terminal_quit='<C-\><C-n>'
endif

function! s:nvimux_bind_key(k, v, modes) abort
  for m in a:modes
    if m == 't'
      let cmd = a:v
    else
      let cmd = g:nvimux_terminal_quit.a:v
    endif
    exec m.'noremap '.g:nvimux_prefix.a:k." ".cmd
  endfor
endfunction

if !exists('$TMUX')
  call s:nvimux_bind_key('c', ':tabe<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('!', ':tabe %<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('%', ':vspl<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('"', ':spl<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('q', ':Ttoggle<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('w', ':tabs<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('o', '<C-w>w', ['n', 'v', 'i', 't'])

  for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
    call s:nvimux_bind_key(i, i.'gt', ['n', 'v', 'i', 't'])
  endfor

  call s:nvimux_bind_key('n', 'gt', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('p', 'gT', ['n', 'v', 'i', 't'])

  call s:nvimux_bind_key('x', ':x<CR>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('X', ':bd %<CR>', ['n', 'v', 'i', 't'])

  call s:nvimux_bind_key(']', 'pa', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('h', '<C-w><C-h>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('j', '<C-w><C-j>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('k', '<C-w><C-k>', ['n', 'v', 'i', 't'])
  call s:nvimux_bind_key('l', '<C-w><C-l>', ['n', 'v', 'i', 't'])

  call s:nvimux_bind_key(':', ':', ['t'])
  call s:nvimux_bind_key('[', '', ['t'])
  "
  " TODO check if can force only on terminal buffer
  call s:nvimux_bind_key(']', 'pa', ['n', 'v', 'i'])
endif
