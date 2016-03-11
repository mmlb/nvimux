 if !exists('$TMUX')
   nnoremap <C-b>c :tabe<CR>
   nnoremap <C-b>! :tabe %<CR>
   nnoremap <C-b>% :vspl<CR>
   nnoremap <C-b>" :spl<CR>
   nnoremap <C-b>q :Ttoggle<CR>
   nnoremap <C-b>w :tabs<CR>

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

   nnoremap <C-b>n gt
   nnoremap <C-b>p gT

   nnoremap <C-b>x :bd %<CR>

   tnoremap <C-b>c <C-\><C-n>:tabe<CR>
   tnoremap <C-b>! <C-\><C-n>:tabe %<CR>
   tnoremap <C-b>% <C-\><C-n>:vnew<CR>
   tnoremap <C-b>" <C-\><C-n>:new<CR>
   tnoremap <C-b>w <C-\><C-n>:tabs<CR>

   tnoremap <C-b>q <C-\><C-n>:Ttoggle<CR>

   tnoremap <C-b>: <C-\><C-n>:
   tnoremap <C-b>[ <C-\><C-n>
   tnoremap <C-b>h <C-\><C-n><C-w><C-h>
   tnoremap <C-b>j <C-\><C-n><C-w><C-j>
   tnoremap <C-b>k <C-\><C-n><C-w><C-k>
   tnoremap <C-b>l <C-\><C-n><C-w><C-l>

   tnoremap <C-b>1 <C-\><C-n>1gt
   tnoremap <C-b>2 <C-\><C-n>2gt
   tnoremap <C-b>3 <C-\><C-n>3gt
   tnoremap <C-b>4 <C-\><C-n>4gt
   tnoremap <C-b>5 <C-\><C-n>5gt
   tnoremap <C-b>6 <C-\><C-n>6gt
   tnoremap <C-b>7 <C-\><C-n>7gt
   tnoremap <C-b>8 <C-\><C-n>8gt
   tnoremap <C-b>9 <C-\><C-n>9gt
   tnoremap <C-b>0 <C-\><C-n>0gt

   tnoremap <C-b>n <C-\><C-n>gt
   tnoremap <C-b>p <C-\><C-n>gT
endif
