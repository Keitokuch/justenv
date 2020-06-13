let plug_path = g:config_path.'plugins/'
let plugins = [
            \ 'vterm',
            \ 'devicons',
            \ 'gitgutter',
            \ 'airline',
            \ 'coc',
            \ 'cpp',
            \ 'ctrlsf',
            \ 'easymotion',
            \ 'interestingwords',
            \ 'leaderf',
            \ 'nerdcommenter',
            \ 'nerdtree',
            \ 'polyglot',
            \ 'python',
            \ 'tagbar',
            \ 'tags',
            \ 'visual-multi',
            \ 'vimtex',
            \]

call plug#begin()
for plug in plugins
    let f = plug_path . plug . '.vim'
    exec 'source' f
endfor
call plug#end()

"""""" Unloaded Plugins 
            \ 'buffet',
            \ 'snazzy',
