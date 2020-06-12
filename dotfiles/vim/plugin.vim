let plug_path = g:config_path.'plugins/'
let plugins = [
            \ 'airline',
            \ 'coc',
            \ 'cpp',
            \ 'ctrlsf',
            \ 'devicons',
            \ 'easymotion',
            \ 'gitgutter',
            \ 'interestingwords',
            \ 'leaderf',
            \ 'nerdcommenter',
            \ 'nerdtree',
            \ 'python',
            \ 'tagbar',
            \ 'tags',
            \ 'vterm',
            \ 'visual-multi',
            \ 'vimtex'
            \]

call plug#begin()

" exec 'source' plug_path . 'plugins.vim'
for plug in plugins
    let f = plug_path . plug . '.vim'
    exec 'source' f
endfor


call plug#end()
