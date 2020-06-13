Plug 'bagrat/vim-buffet'

" ----------------------- vim-buffet -------------------------
map <silent><expr> <leader>] buflisted(bufnr("%"))? ":bn\<CR>" : ""
map <silent><expr> <leader>[ buflisted(bufnr("%"))? ":bp\<CR>" : ""
map <silent><expr> <leader>w buflisted(bufnr("%"))? ":Bw\<CR>" : ":q\<CR>"
map <leader><leader>] :+tabnext<CR>
map <leader><leader>[ :-tabnext<CR>
map <leader><leader>t : tabe<CR>
function! g:BuffetSetCustomColors()
    hi! link BuffetCurrentBuffer TabLineSel
    hi! link BuffetActiveBuffer  TabAlt
    hi! link BuffetBuffer        TabLine
    hi! link BuffetTab           Block
endfunction
let g:buffet_show_index = 1
let g:buffet_use_devicons = 0
let g:buffet_powerline_separators = 0
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
