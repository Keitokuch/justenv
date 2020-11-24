Plug 'bagrat/vim-buffet'

" ----------------------- vim-buffet -------------------------
map <silent><expr> <leader>; buflisted(bufnr("%"))? ":bn\<CR>" : ""
map <silent><expr> <leader>l buflisted(bufnr("%"))? ":bp\<CR>" : ""
" map <silent><expr> <leader>w buflisted(bufnr("%"))? ":Bw\<CR>" : ":q\<CR>"
map <leader>] :+tabnext<CR>
map <leader>[ :-tabnext<CR>
map <leader><leader>t : tabe<CR>
let g:buffet_show_index = 1
let g:buffet_use_devicons = 1
let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"

function! g:BuffetSetCustomColors()
    hi! link BuffetCurrentBuffer TabLineSel
    hi! link BuffetActiveBuffer  TabAlt
    hi! link BuffetBuffer        TabLine
    hi! link BuffetTab           Block
endfunction

nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)

nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
