if !exists('g:nvimux_prefix')
  let g:nvimux_prefix='<C-b>'
endif

if !exists('g:nvimux_terminal_quit')
  let g:nvimux_terminal_quit='<C-\><C-n>'
endif

function! s:nvimux_bind_key_normal(k, v) abort
  exec 'nnoremap '.g:nvimux_prefix.a:k." ".a:v
endfunction

function! s:nvimux_bind_key_term(k, v) abort
  exec 'tnoremap '.g:nvimux_prefix.a:k." ".g:nvimux_terminal_quit.a:v
endfunction

function! s:nvimux_define_normal_bindings()
  call s:nvimux_bind_key_normal('c', ':tabe<CR>')
  call s:nvimux_bind_key_normal('!', ':tabe %<CR>')
  call s:nvimux_bind_key_normal('%', ':vspl<CR>')
  call s:nvimux_bind_key_normal('"', ':spl<CR>')
  call s:nvimux_bind_key_normal('q', ':Ttoggle<CR>')
  call s:nvimux_bind_key_normal('w', ':tabs<CR>')
  call s:nvimux_bind_key_normal('o', '<C-w>w')

  for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
    call s:nvimux_bind_key_normal(i, i.'gt')
  endfor

  call s:nvimux_bind_key_normal('n', 'gt')
  call s:nvimux_bind_key_normal('p', 'gT')

  call s:nvimux_bind_key_normal('x', ':x<CR>')
  call s:nvimux_bind_key_normal('X', ':bd %<CR>')

  call s:nvimux_bind_key_normal(']', 'pa')

endfunction

function! s:nvimux_define_terminal_bindings()
  call s:nvimux_bind_key_term('c', ':tabe<CR>')
  call s:nvimux_bind_key_term('!', ':tabe %<CR>')
  call s:nvimux_bind_key_term('%', ':vnew<CR>')
  call s:nvimux_bind_key_term('"', ':new<CR>')
  call s:nvimux_bind_key_term('w', ':tabs<CR>')

  call s:nvimux_bind_key_term('q', ':Ttoggle<CR>')

  call s:nvimux_bind_key_term(':', ':')
  call s:nvimux_bind_key_term('[', '')
  call s:nvimux_bind_key_term('h', '<C-w><C-h>')
  call s:nvimux_bind_key_term('j', '<C-w><C-j>')
  call s:nvimux_bind_key_term('k', '<C-w><C-k>')
  call s:nvimux_bind_key_term('l', '<C-w><C-l>')
  call s:nvimux_bind_key_term('o', '<C-w>w')

  for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
    call s:nvimux_bind_key_term(i, i.'gt')
  endfor

  call s:nvimux_bind_key_term('n', 'gt')
  call s:nvimux_bind_key_term('p', 'gT')

endfunction

if !exists('$TMUX')
  call s:nvimux_define_normal_bindings()
  call s:nvimux_define_terminal_bindings()
endif
