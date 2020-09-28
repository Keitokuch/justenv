let g:plug_path = g:config_path . 'plugins/'
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
            \ 'colors',
            \ 'colorschemes',
            \ 'syntastic',
            \ 'java',
            \ 'indent',
            \ 'scrollbar',
            \ 'vimtex',
            \ 'vterm',
            \ 'leaderf',
            \ 'go',
            \ 'pairs'
            \]

let g:nvim_plugins = [
            \]

"""""" Unloaded Plugins 
            \ 'minimap',
            \ 'buffet',
            \ 'snazzy',


let g:plugins = has('nvim') ? plugins + nvim_plugins : plugins
call plug#begin()
for plug in plugins
    let f = plug_path . plug . '.vim'
    exec 'source' f
endfor
call plug#end()
