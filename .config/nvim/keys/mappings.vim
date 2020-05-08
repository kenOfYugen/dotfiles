" Enable folding with spacebar
nnoremap <space> za

" Split navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Split resizing
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

noremap <silent> <C-V> :vsplit <CR>

" Nerdtree Toggle
map <C-n> :NERDTreeToggle<CR>

" Hackerman
cmap w!! w !sudo tee %
