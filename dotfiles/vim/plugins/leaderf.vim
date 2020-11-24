Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" ------------------- Mappings -----------------
map <leader>r :LeaderfFunction<cr>
map <leader>R :LeaderfFunctionAll<cr>
" map <leader>t :LeaderfBufTagAll<cr>
" map <leader>T :LeaderfTag<cr>
map <leader>t :LeaderfBuffer<cr>
map <leader>o :LeaderfFile<cr>
" map <leader>o :LeaderfMruCwd<cr>
nmap  /       :LeaderfLine<cr>

command Color       LeaderfColorscheme
command Filetype    LeaderfFiletype
command Ft          LeaderfFiletype
let g:Lf_ShortCutB = '<C-B>'
let g:Lf_ShortCutF = '<C-B>'

" ---------------------------------------- Leaderf ---------------------------------------------
let g:Lf_JumpToExistingWindow = 0
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_PythonVersion = 3
let g:Lf_UseCache = 0
" let g:Lf_WindowPosition = 'popup'
let g:Lf_WindowHeight = 0.35
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

