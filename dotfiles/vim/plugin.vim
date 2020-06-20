let plug_path = g:config_path.'plugins/'
let g:plugins = [
            \ 'devicons',
            \ 'gitgutter',
            \ 'airline',
            \ 'coc',
            \ 'cpp',
            \ 'ctrlsf',
            \ 'easymotion',
            \ 'interestingwords',
            \ 'nerdcommenter',
            \ 'nerdtree',
            \ 'polyglot',
            \ 'python',
            \ 'tagbar',
            \ 'tags',
            \ 'visual-multi',
            \ 'vimtex',
            \ 'vterm',
            \ 'leaderf',
            \ 'go',
            \]

let nvim_plugins = [
            \]


"""""" Unloaded Plugins 
            \ 'buffet',
            \ 'snazzy',

call plug#begin()
let plugins = has('nvim') ? plugins + nvim_plugins : plugins
for plug in plugins
    let f = plug_path . plug . '.vim'
    exec 'source' f
endfor
call plug#end()

