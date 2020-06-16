let g:config_path = resolve(expand('<sfile>:p:h')).'/'
if has('nvim')
    exec 'source' g:config_path . 'nvim.vim'
else
    " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

exec 'source' g:config_path . 'config.vim'
exec 'source' g:config_path . 'functions.vim'
exec 'source' g:config_path . 'mappings.vim'
exec 'source' g:config_path . 'plugin.vim'
exec 'source' g:config_path . 'autocmd.vim'
