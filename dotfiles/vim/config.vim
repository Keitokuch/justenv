" -------------------- Color Scheme -------------------
colorscheme vim-keitoku

" ----------------- Options ----------------
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
set mouse=a
set scrolloff=13
set showtabline=2
set noswapfile
set noshowmode
set splitbelow
set splitright
set cursorline
set exrc

set termguicolors
syntax on

" Clipboard
" set clipboard^=unnamed
" set clipboard^=unnamedplus,unnamed
set clipboard=""
nnoremap p "*p
vnoremap p "*p
nnoremap d "*d
vnoremap d "*d
nnoremap y "*y
vnoremap y "*y
nnoremap P "*P
vnoremap P "*P
nnoremap D "*D
vnoremap D "*D

" ======================== Languages ==========================
" -------------- Lua -----------------
hi def link LuaFunction             FunctionDeclaration
hi def link LuaIn                   Conditional
