Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"" -------------------- Nerd-Tree ----------------------
map <leader>d :NERDTreeToggle<CR>
map <silent><expr> sf exists("b:NERDTree") ? "\<C-w>p" : ":NERDTreeFocus<CR>"
map <silent><expr> sF exists("b:NERDTree") ? "\<C-w>p" : ":NERDTreeFind<CR>"
let NERDTreeMapOpenVSplit='so'
let NERDTreeMapToggleZoom='a'

let g:NERDTreeWinSize=24
let g:NERDTreeMinimalUI=1
autocmd StdinReadPre * let s:std_in=1

" When NERDTree is the only window left
" open empty buffer if started by opening a directory
" quit otherwise
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() && g:DIR_START == 0) | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() && g:DIR_START == 1) | enew | exe 'NERDTreeToggle' | endif

