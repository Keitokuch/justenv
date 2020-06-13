" Neovim Configuration
let g:python_host_prog = system('which python')[:-2]
let g:python3_host_prog = system('which python3')[:-2]

let g:config_path = expand('~/.config/nvim/')

exec 'source' g:config_path . 'config.vim'
exec 'source' g:config_path . 'functions.vim'
exec 'source' g:config_path . 'mappings.vim'
exec 'source' g:config_path . 'autocmd.vim'
exec 'source' g:config_path . 'plugin.vim'
