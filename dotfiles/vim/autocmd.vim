"  Vim autocmds
"
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
autocmd FileType help wincmd L | vert resize 80

"" ====================== Additional Features ========================
" Start from last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Automatically Save and Restore Session
autocmd VimEnter * nested call StartSetup()
autocmd VimLeave * call LeaveSetup()

" Automatically install missing plugins on startup
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif
