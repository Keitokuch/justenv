let g:config_path = resolve(expand('<sfile>:p:h')).'/'
if has('nvim')
    exec 'source' g:config_path . 'nvim.vim'
endif

exec 'source' g:config_path . 'config.vim'
exec 'source' g:config_path . 'functions.vim'
exec 'source' g:config_path . 'mappings.vim'
exec 'source' g:config_path . 'autocmd.vim'
exec 'source' g:config_path . 'plugin.vim'
