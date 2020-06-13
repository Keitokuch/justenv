Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

"" ------------------------------------ coc.nvim -------------------------------------------
" coc-pairs, coc-snippets
" coc-python, coc-json, coc-vimtex, coc-html, coc-java

let g:coc_global_extensions=['coc-pairs', 'coc-snippets', 'coc-json', 'coc-python', 'coc-vimtex']
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <tab> to jump in snippets
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>":
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ "\<TAB>"

" use <tab> and <s-tab> for trigger completion and navigate to complete items
" inoremap <silent><expr> <Tab>
"             \ pumvisible() ? "\<C-n>" :
"             \ <SID>check_back_space() ? "\<Tab>" :
"             \ coc#refresh()


" use <cr> to confirm completion
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" make <cr> select the first completion item and confirm the completion when no item has been selected
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" Remap for rename current word
nmap \rn <Plug>(coc-rename)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

