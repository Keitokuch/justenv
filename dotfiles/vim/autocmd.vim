"  Vim autocmds
"
" Automatically install missing plugins on startup
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif

autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
autocmd BufWinEnter * if &buftype == "help" | wincmd L | vert resize 80 | endif

"" ====================== Additional Features ========================
" Start from last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup startup
    " Automatically Save and Restore Session
    autocmd VimEnter * nested call StartSetup()
    autocmd VimLeave * call LeaveSetup()
augroup end

au VimEnter * set tabline=%!MyTabline()

" Unlisted filetypes
augroup unlistbuf
    au Filetype rst set nobuflisted     " do not list python doc files
    au Filetype log set nobuflisted     " do not list log files
augroup end
