if !exists('g:nvimux_prefix')
  let g:nvimux_prefix='<C-b>'
endif

if !exists('g:nvimux_terminal_quit')
  let g:nvimux_terminal_quit='<C-\><C-n>'
endif

function! s:nvimux_define_normal_bindings()
  exec 'nnoremap '.g:nvimux_prefix.'c :tabe<CR>'
  exec 'nnoremap '.g:nvimux_prefix.'! :tabe %<CR>'
  exec 'nnoremap '.g:nvimux_prefix.'% :vspl<CR>'
  exec 'nnoremap '.g:nvimux_prefix.'" :spl<CR>'
  exec 'nnoremap '.g:nvimux_prefix.'q :Ttoggle<CR>'
  exec 'nnoremap '.g:nvimux_prefix.'w :tabs<CR>'
  exec 'nnoremap '.g:nvimux_prefix.'o <C-w>w'

  for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
    exec 'nnoremap '.g:nvimux_prefix.i.' '.i.'gt'
  endfor

  exec 'nnoremap '.g:nvimux_prefix.'n gt'
  exec 'nnoremap '.g:nvimux_prefix.'p gT'

  exec 'nnoremap '.g:nvimux_prefix.'x :x<CR>'
  exec 'nnoremap '.g:nvimux_prefix.'X :bd %<CR>'

  exec 'nnoremap '.g:nvimux_prefix.'] pa'

endfunction

function! s:nvimux_define_terminal_bindings()
  exec 'tnoremap '.g:nvimux_prefix.'c '.g:nvimux_terminal_quit.':tabe<CR>'
  exec 'tnoremap '.g:nvimux_prefix.'! '.g:nvimux_terminal_quit.':tabe %<CR>'
  exec 'tnoremap '.g:nvimux_prefix.'% '.g:nvimux_terminal_quit.':vnew<CR>'
  exec 'tnoremap '.g:nvimux_prefix.'" '.g:nvimux_terminal_quit.':new<CR>'
  exec 'tnoremap '.g:nvimux_prefix.'w '.g:nvimux_terminal_quit.':tabs<CR>'

  exec 'tnoremap '.g:nvimux_prefix.'q '.g:nvimux_terminal_quit.':Ttoggle<CR>'

  exec 'tnoremap '.g:nvimux_prefix.': '.g:nvimux_terminal_quit.':'
  exec 'tnoremap '.g:nvimux_prefix.'[ '.g:nvimux_terminal_quit.''
  exec 'tnoremap '.g:nvimux_prefix.'h '.g:nvimux_terminal_quit.'<C-w><C-h>'
  exec 'tnoremap '.g:nvimux_prefix.'j '.g:nvimux_terminal_quit.'<C-w><C-j>'
  exec 'tnoremap '.g:nvimux_prefix.'k '.g:nvimux_terminal_quit.'<C-w><C-k>'
  exec 'tnoremap '.g:nvimux_prefix.'l '.g:nvimux_terminal_quit.'<C-w><C-l>'
  exec 'tnoremap '.g:nvimux_prefix.'o '.g:nvimux_terminal_quit.'<C-w>w'

  for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
    exec 'tnoremap '.g:nvimux_prefix.i.' 'g:nvimux_terminal_quit.i.'gt'
  endfor

  exec 'tnoremap '.g:nvimux_prefix.'n '.g:nvimux_terminal_quit.'gt'
  exec 'tnoremap '.g:nvimux_prefix.'p '.g:nvimux_terminal_quit.'gT'

endfunction

if !exists('$TMUX')
  call s:nvimux_define_normal_bindings()
  call s:nvimux_define_terminal_bindings()
endif
