let plug_path = g:config_path.'plugins/'
let plugins = [
            \ 'nerdtree',
            \ 'devicons',
            \ 'gitgutter',
            \ 'interestingwords',
            \ 'coc',
            \ 'airline',
            \ 'python',
            \ 'LeaderF',
            \ 'tagbar',
            \ 'gutentags',
            \ 'vterm',
            \ 'visual-multi',
            \ 'ctrlsf',
            \ 'vimtex',
            \ 'snippets',
            \ 'cpp',
            \ 'nerdcommenter',
            \ 'easymotion'
            \]

call plug#begin()

exec 'source' plug_path . 'plugins.vim'
" for plug in plugins
"     f = plug_path . plug . '.vim'
"     exec 'source' f
" endfor

call plug#end()
