Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

let g:coc_global_extensions=['coc-snippets', 'coc-json']

" ------------------------ Mappings -------------------------

nmap \rn <Plug>(coc-rename)
nmap \rf <Plug>(coc-refactor)
nmap \i  :call CocActionAsync('organizeImport')<CR>:echo 'imports organized'<CR>
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Formatting selected code.
xmap \f  <Plug>(coc-format-selected)
nmap \f  <Plug>(coc-format)
nmap \qf <Plug>(coc-fix-current)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" use <tab> <S-tab> to select completion and jump in snippets
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>":
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ "\<TAB>"
" inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
map <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-k>"
xmap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-k>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-k>"

" When not in snippet, Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter
inoremap <silent><expr> <CR> coc#jumpable() ? pumvisible() ? "\<C-y>" : "\<CR>" :
            \ pumvisible() ? coc#_select_confirm() :
            \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<C-k>'


"" ------------------------------------ coc.nvim -------------------------------------------
" coc-pairs, coc-snippets
" coc-python, coc-json, coc-vimtex, coc-html, coc-java, coc-go


autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
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

" use <tab> and <s-tab> for trigger completion and navigate to complete items
" inoremap <silent><expr> <Tab>
"             \ pumvisible() ? "\<C-n>" :
"             \ <SID>check_back_space() ? "\<Tab>" :
"             \ coc#refresh()


" use <cr> to confirm completion
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
