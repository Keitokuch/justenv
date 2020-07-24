Plug 'lervag/vimtex', { 'for': 'tex' }

let g:coc_global_extensions+=['coc-vimtex']

" ---------------- tex -----------------
let g:tex_flavor='latex'
let g:vimtex_view_method='general'
set conceallevel=0
let g:tex_conceal='abdmgs'
let g:vimtex_quickfix_mode=2
let g:vimtex_quickfix_autoclose_after_keystrokes = 3
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_ignore_all_warnings = 1
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : '.latex_aux',
            \ 'options' : [
            \       '--shell-escape',
            \  ],
            \}

augroup vimtex_config
    autocmd Filetype tex nmap <leader>c :VimtexCompile<CR>
    autocmd Filetype tex inoremap <expr> $ strpart(getline('.'), col('.')-1, 1) == "$" ? "\<Right>" : "$$<left>"
    " Start Compilation automatically on enter?
    "autocmd User VimtexEventInitPost VimtexCompile
augroup end
