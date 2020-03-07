" neovim specific 
let g:python2_host_prog = system('which python')[:-2]
let g:python3_host_prog = system('which python3')[:-2]

" ----------------- Options ----------------
syntax on 
set nocompatible
set number
set relativenumber
set wrap
set showcmd
set wildmenu
filetype plugin indent on 
set encoding=utf-8
let &t_ut=''
set expandtab 
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
set hlsearch 
set incsearch
set ignorecase
set smartcase
set autoindent
set smartindent
set cindent
set tabstop=4
set shiftwidth=4
set guioptions-=T
set vb t_vb=
set ruler
set nohls
"set runtimepath+=~/.vim
set history=1000 
set laststatus=2    "always show status
set clipboard=unnamed 
set mouse=a
set termguicolors 
set scrolloff=13
set showtabline=2
autocmd FileType help wincmd L | vert resize 80
set noswapfile

set noshowmode
set splitbelow 
set splitright
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
cmap w!! w !sudo tee%

" -------------------- Color Scheme -------------------
let g:airline_theme='onehalfdark'
colorscheme vim-keitoku

" ============================ Key Mappings =============================
let mapleader=" "
inoremap jj <ESC>
map q <ESC>
nnoremap Q q
cnoremap qq <C-c>
cnoremap jj <C-c>
map <C-i> 10k
map <C-d> 10j
nnoremap Y :%y<CR>
nnoremap <leader>= gg=G<C-o>
command Sudow w !sudo dd of=%

"" Split
map s <nop>
map S <nop>
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
map <leader>l <C-w>l
map <leader>h <C-w>h
map <leader>k <C-w>k
map <leader>j <C-w>j
map <leader>p <C-w>p
map <S-C-up> :resize +5<CR>
map <S-C-down> :resize -5<CR>
map <S-C-left> :vertical resize-5<CR>
map <S-C-right> :vertical resize+5<CR>
map <leader><C-w> :q<CR>
map <leader>W :q<CR>

map <M-up> :resize +5<CR>
map <M-down> :resize -5<CR>
map <M-left> :vertical resize-5<CR>
map <M-right> :vertical resize+5<CR>

"" Tab
map <leader>t :tabe<CR>
map <leader>] :+tabnext<CR>
map <leader>[ :-tabnext<CR>

"" Buffer 
map <leader>s :w<CR>
map <leader>q :qall<CR>
map <leader>w :q<CR>
map <silent><expr> <leader>w buflisted(bufnr("%"))? ":bp<cr>:bd #<cr>" : ":q\<CR>"

"" Jumping
" tag jump
nnoremap <C-p> <C-]>
" next position
nnoremap <C-u> <C-i> 
" jump last tag 
nnoremap <C-y> <C-t>

"" Insert mode
inoremap <silent><expr> <C-e> pumvisible()? "\<C-e>" : "\<ESC>A"
inoremap <C-a> <ESC>I
inoremap <C-f> <right>
inoremap <C-b> <left>
inoremap <silent><expr> <C-p> pumvisible()? "\<C-p>" : "\<up>"
inoremap <silent><expr> <C-n> pumvisible()? "\<C-n>" : "\<down>"


"" Terminal mode 
tnoremap qq <C-\><C-n>

" Minimal auto closing
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "''<left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"<left>""
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"


"" ====================== Additional Features ========================
" Start from last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"" ========================== Vim-Plug ========================
call plug#begin()

Plug 'scrooloose/nerdtree'
""
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 
Plug 'ryanoasis/vim-devicons'
""
Plug 'airblade/vim-gitgutter'
Plug 'lfv89/vim-interestingwords'
Plug 'connorholyday/vim-snazzy'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sonph/onehalf', {'rtp':'vim/'}
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen', 'TagbarShowTag'] }
Plug 'ludovicchabant/vim-gutentags'
Plug 'keitokuch/vterm'
Plug 'mg979/vim-visual-multi'
Plug 'dyng/ctrlsf.vim'
Plug 'lervag/vimtex', { 'for': 'tex' }
"Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp', 'cuda'] }
Plug 'vim-scripts/TagHighlight'
"Plug 'mkitt/tabline.vim'
"Plug 'jistr/vim-nerdtree-tabs'
Plug 'bagrat/vim-buffet'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif

" Restore Session 
autocmd VimEnter * nested call StartSetup()
autocmd VimLeave * call LeaveSetup()

" ====================== Plugin Configs ==========================

"" -------------------- Nerd-Tree ----------------------
map <leader>d :NERDTreeToggle<CR>
map <silent><expr> sf exists("b:NERDTree") ? "\<C-w>p" : ":NERDTreeFocus<CR>"
map <silent><expr> sF exists("b:NERDTree") ? "\<C-w>p" : ":NERDTreeFind<CR>"
let g:NERDTreeWinSize=24
let g:NERDTreeMinimalUI=1 
let NERDTreeMapOpenVSplit='so'
let NERDTreeMapToggleZoom='a'
autocmd StdinReadPre * let s:std_in=1

" When NERDTree is the only window left 
" open empty buffer if started by opening a directory
" quit otherwise
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() && g:DIR_START == 0) | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() && g:DIR_START == 1) | enew | exe 'NERDTreeToggle' | endif

" ---------------------- Nerdtree tabs --------------------
"map ss <plug>NERDTreeTabsToggle<CR>
"let g:nerdtree_tabs_open_on_console_startup = 1
"let g:nerdtree_tabs_autofind = 1

" --------------------- vim-airline --------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>[ <Plug>AirlineSelectPrevTab
nmap <leader>] <Plug>AirlineSelectNextTab
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#middle_click_preserves_windows = 1
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['vimfiler', 'nerdtree', 'terminal', 'tagbar', 'help']


"" ------------------ vim-gitgutter -------------------
" unmap conflict leader combo 
let g:gitgutter_map_keys = 0 

"" -------------------- nerdcommenter ----------------
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
map <leader>/ <plug>NERDCommenterInvert
imap j; <plug>NERDCommenterInsert


"" ------------------- interesting words -------------------
map <silent> <leader>i <Plug>InterestingWords<nop>
map <silent> <leader>I <Plug>InterestingWordsClear
map n <Plug>InterestingWordsForeward
map N <Plug>InterestingWordsBackward

"" ---------------------- easymotion -------------------------------
map <space>; <Plug>(easymotion-overwin-f)
map ; <Plug>(easymotion-s)
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 1
nmap  / <Plug>(easymotion-sn)
"d,y,c operators 
omap / <Plug>(easymotion-tn)  

"" ------------------------------------ coc.nvim -------------------------------------------
" coc-python, coc-json, coc-pairs, coc-vimtex, coc-html,
" coc-neosnippet, coc-java, coc-snippets
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" use <tab> and <s-tab> for trigger completion and navigate to complete items
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <tab> to jump in snippets
inoremap <silent><expr> <TAB>
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ pumvisible() ? "\<C-n>":
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

" use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" --------------------- neosnippet ------------------------
"

" ------------------------- Tagbar ----------------------------
map tt :TagbarToggle<CR>
map <silent><expr> st b:current_syntax == "tagbar" ? "\<C-w>p" : ":TagbarOpen fj<CR>"
let g:tagbar_width = 25
let g:tagbar_autofocus = 0
let g:tagbar_sort = 0
let g:tagbar_map_jump = ["o", "<CR>"]
let g:tagbar_map_close = ["q", "tt"]
let g:tagbar_map_showproto = "v"
let g:tagbar_map_togglefold = ["x"]
let g:tagbar_map_zoomwin = "a"
let g:tagbar_map_togglesort = "so"

" ------------------------------------ vim-gutentags ----------------------------------
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'

" ---------------------------------------- Leaderf ---------------------------------------------
let g:Lf_ShowRelativePath = -1
let g:Lf_HideHelp = 1
map <leader>r :LeaderfFunction<cr>
map <leader>t :LeaderfBufTagAll<cr>
map <leader>T :LeaderfTag<cr>
map <leader>o :LeaderfBuffer<cr>
map <leader>O :LeaderfFile<cr>
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

" ------------------------------ ctrlsf ----------------------------
nmap     <C-f> <Plug>CtrlSFCwordPath
vmap     <C-f> <Plug>CtrlSFVwordPath
nnoremap <leader>f :CtrlSFToggle<CR>

" ------------------------- vim-visual-multi -------------------------
let g:VM_theme = 'ocean'
nmap   <S-LeftMouse>         <Plug>(VM-Mouse-Cursor)
nmap   <S-RightMouse>        <Plug>(VM-Mouse-Word)  
nmap   <S-C-RightMouse>      <Plug>(VM-Mouse-Column)
let g:VM_maps = {}
let g:VM_maps["Switch Mode"]        = 'v'
let g:VM_maps['Find Under']         = '<C-n>'           
let g:VM_maps["Add Cursor Down"]    = '<S-Down>'      
let g:VM_maps["Add Cursor Up"]      = '<S-Up>'       
let g:VM_maps["Remove Region"]      = 'x'
let g:VM_maps["x"]                  = ''
let g:VM_maps["Skip Region"]        = '<C-x>'
let g:VM_maps["Undo"]               = 'u'
let g:VM_maps["Redo"]               = '<C-r>'
let g:VM_maps["Add Cursor At Pos"]  = '+'


"------------------------- ultisnips -------------------------  
let g:UltiSnipsExpandTrigger = 'C-;'
let g:UltiSnipsJumpForwardTrigger = 'nn'
let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'

" ------------------------- vterm -----------------------------
let g:vterm_win_height = 20

" ----------------------- cpp-enhanced-highlight ------------------------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
hi def link cCustomMemVar           Identifier
hi def link cCustomPtr              Operator

" ----------------------- vim-buffet -------------------------
"map <silent><expr> <leader>] buflisted(bufnr("%"))? ":bn\<CR>" : ""
"map <silent><expr> <leader>[ buflisted(bufnr("%"))? ":bp\<CR>" : ""
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


" ======================== Languages ==========================

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
            \}
augroup vimtex_config
    autocmd Filetype tex nmap <leader>c :VimtexCompile<CR>
    autocmd Filetype tex inoremap <expr> $ strpart(getline('.'), col('.')-1, 1) == "$" ? "\<Right>" : "$$<left>"
    " Start Compilation automatically on enter?
    "autocmd User VimtexEventInitPost VimtexCompile 
augroup end

" ------------- Python ---------------
au Filetype rst set nobuflisted     " do not list doc files
let g:pymode_python = 'python3'
let g:pymode_warnings = 1
let g:pymode_syntax_space_errors = 0
let g:pymode_trim_whitespaces = 1
let g:pymode_lint_cwindow = 0 
let g:pymode_motion = 1
let g:pymode_lint_checkers = ['pep8']
let g:pymode_run_bind = '<leader>c'
hi def link pythonParam             Identifier
hi def link pythonClassParameters   Identifier
hi def link pythonSelf              Conventional
hi def link pythonOperator          Keyword
hi def link pythonFunction          FunctionDeclaration 
hi def link pythonBuiltinFunc       BuiltinFunc 
au Filetype python syntax match pythonFunctionCall /\v[[:alpha:]_]+\ze(\s?\()/
hi def link pythonFunctionCall FunctionCall

" -------------- Lua -----------------
hi def link LuaFunction             FunctionDeclaration 
hi def link LuaIn                   Conditional

" ----------------- C family --------------
hi def link cFormat                 Type  

au BufNewFile,BufRead,BufReadPost *.ejs set syntax=html

" ================== Utils ===================
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <C-g> :call <SID>SynStack()<CR>

fu! StartSetup()
    if (argc() == 0 && !exists("s:std_in"))
        let g:DIR_START = 1 
        if !RestoreSess()
            exe 'NERDTreeToggle'
        endif 
    elseif argc() == 1 && isdirectory(argv()[0]) == 1 && !exists("s:std_in")
        let g:DIR_START = 1 
        exe 'cd ' . argv()[0]
        if !RestoreSess()
            exe 'NERDTreeToggle' argv()[0] | wincmd p | ene 
        endif 
    else
        let g:DIR_START=0 
    endif 
endfu 

fu! RestoreSess()
    if filereadable(getcwd() . '/.Session.vim')
        exe 'so ' . getcwd() . '/.Session.vim'
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    exe 'sbuffer ' . l
                endif
            endfor
        endif
        exe 'NERDTreeFind' | wincmd p 
        return 1
    else 
        return 0 
    endif
endfunction

fu! LeaveSetup()
    let currTab = tabpagenr()
    tabdo helpclose
    if exists('g:loaded_nerd_tree') | tabdo NERDTreeClose
    endif
    if exists('g:loaded_vterm') | tabdo VTermClose
    endif
    if exists('g:loaded_tagbar') | tabdo TagbarClose
    endif
    exe 'tabn ' . currTab
    mksession! ./.Session.vim
endfu 

function! MyTabline()
    " let tabline=buffet#render()
    let tabline=airline#extensions#tabline#get()
    if g:NERDTree.IsOpen()
        let width = winwidth(g:NERDTree.GetWinNum())
        let tabline = '%#Normal#' . repeat(' ', width) . '%#VertSplit# ' . tabline
    endif 
    return tabline
endfunction 
au VimEnter * set tabline=%!MyTabline()
