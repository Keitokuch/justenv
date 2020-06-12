Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" ---------------------------------------- Leaderf ---------------------------------------------
let g:Lf_ShowRelativePath = -1
let g:Lf_HideHelp = 1
map <leader>r :LeaderfFunction<cr>
map <leader>t :LeaderfBufTagAll<cr>
map <leader>T :LeaderfTag<cr>
map <leader>o :LeaderfBuffer<cr>
map <leader>O :LeaderfFile<cr>
let g:Lf_ShortCutB = ''
let g:Lf_ShortCutF = ''
" let g:Lf_WindowPosition = 'popup'
let g:Lf_WindowHeight = 0.35
let g:Lf_NeedCacheTime = 0.8
nmap  /        :LeaderfLine<cr>
let g:Lf_NormalMap = {
            \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>'],
            \            ["<C-C>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
            \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>'],
            \            ["<C-C>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
            \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>'],
            \            ["<C-C>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
            \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>'],
            \            ["<C-C>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
            \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>'],
            \            ["<C-C>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
            \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>'],
            \            ["<C-C>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
            \ }
let g:Lf_CommandMap =  {
            \           '<ESC>': ['<C-T>', '<ESC>', '<C-Q>'],
            \           '<Home>': ['<C-A>'],
            \           '<End>': ['<C-E>'],
            \           '<Left>': ['<C-B>', '<Left>'],
            \           '<Right>': ['<C-F>', '<Right>'],
            \           '<Up>': ['<C-P>'],
            \           '<Down>': ['<C-N>'],
            \           '<C-J>': ['<Down>'],
            \           '<C-K>': ['<Up>']
            \            }

