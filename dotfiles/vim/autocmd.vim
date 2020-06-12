"  Vim autocmds
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
autocmd FileType help wincmd L | vert resize 80


"" ====================== Additional Features ========================
" Start from last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
