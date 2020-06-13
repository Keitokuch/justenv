Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen', 'TagbarShowTag'] }

" ------------------------- Tagbar ----------------------------
map tt :TagbarToggle<CR>
map <silent><expr> st b:current_syntax == "tagbar" ? "\<C-w>p" : ":TagbarOpen fj<CR>"

let g:tagbar_map_jump = ["o", "<CR>"]
let g:tagbar_map_close = ["q", "tt"]
let g:tagbar_map_showproto = "v"
let g:tagbar_map_togglefold = ["x"]
let g:tagbar_map_zoomwin = "a"
let g:tagbar_map_togglesort = "so"

let g:tagbar_width = 25
let g:tagbar_autofocus = 0
let g:tagbar_sort = 0
