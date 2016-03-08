 if !exists('$TMUX')
   nnoremap <C-b>c :tabe<CR>
   nnoremap <C-b>! :tabe %<CR>
   nnoremap <C-b>% :vspl<CR>
   nnoremap <C-b>\" :spl<CR>
   nnoremap <C-b>q :Ttoggle<CR>
   nnoremap <C-b>w :tabs<CR>

   tnoremap <C-b>c <C-\\><C-n>:tabe<CR>
   tnoremap <C-b>! <C-\\><C-n>:tabe %<CR>
   tnoremap <C-b>% <C-\\><C-n>:vnew<CR>
   tnoremap <C-b>\" <C-\\><C-n>:new<CR>
   tnoremap <C-b>q <C-\\><C-n>:Ttoggle<CR>
   tnoremap <C-b>w <C-\\><C-n>:tabs<CR>

   nnoremap <C-b>1 1gt
   nnoremap <C-b>2 2gt
   nnoremap <C-b>3 3gt
   nnoremap <C-b>4 4gt
   nnoremap <C-b>5 5gt
   nnoremap <C-b>6 6gt
   nnoremap <C-b>7 7gt
   nnoremap <C-b>8 8gt
   nnoremap <C-b>9 9gt
   nnoremap <C-b>0 0gt

   tnoremap <C-b>: <C-\\><C-n>:
   tnoremap <C-b><C-b> <C-\\><C-n>
   tnoremap <C-b>h <C-\\><C-n><C-w><C-h>
   tnoremap <C-b>j <C-\\><C-n><C-w><C-j>
   tnoremap <C-b>k <C-\\><C-n><C-w><C-k>
   tnoremap <C-b>l <C-\\><C-n><C-w><C-l>
endif
