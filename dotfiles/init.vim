" neovim Python env
" let g:python2_host_prog = system('which python')[:-2]
let g:loaded_python_provider = 0
let g:python3_host_prog = system('which python3')[:-2]

let g:config_path = expand('~/.config/nvim/')

exec 'source' g:config_path . 'config.vim'
exec 'source' g:config_path . 'functions.vim'
exec 'source' g:config_path . 'mappings.vim'
exec 'source' g:config_path . 'autocmd.vim'
exec 'source' g:config_path . 'plugin.vim'


" "" ========================== Vim-Plug ========================
" call plug#begin()

" Plug 'scrooloose/nerdtree'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'ryanoasis/vim-devicons'
" Plug 'airblade/vim-gitgutter'
" Plug 'lfv89/vim-interestingwords'
" " Plug 'connorholyday/vim-snazzy'
" Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocInstall coc-pairs coc-snippets'}
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'sonph/onehalf', {'rtp':'vim/'}
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen', 'TagbarShowTag'] }
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'keitokuch/vterm'
" Plug 'mg979/vim-visual-multi'
" Plug 'dyng/ctrlsf.vim'
" Plug 'lervag/vimtex', { 'for': 'tex' }
" "Plug 'sirver/ultisnips'
" Plug 'honza/vim-snippets'
" Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp', 'cuda'] }
" " Plug 'vim-scripts/TagHighlight'
" "Plug 'mkitt/tabline.vim'
" "Plug 'jistr/vim-nerdtree-tabs'
" " Plug 'bagrat/vim-buffet'
" "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" " Plug 'Shougo/neosnippet.vim'
" " Plug 'Shougo/neosnippet-snippets'
" Plug 'scrooloose/nerdcommenter'
" Plug 'easymotion/vim-easymotion'

" call plug#end()

" " Automatically install missing plugins on startup
" autocmd VimEnter *
"             \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"             \|   PlugInstall --sync | q
"             \| endif

" " Restore Session
" autocmd VimEnter * nested call StartSetup()
" autocmd VimLeave * call LeaveSetup()
