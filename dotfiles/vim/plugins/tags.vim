Plug 'ludovicchabant/vim-gutentags'

" ------------------------------------ vim-gutentags ----------------------------------
augroup statusline
    " this one is which you're most likely to use?
    autocmd VimEnter set statusline+=%{gutentags#statusline()}
augroup end
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'
