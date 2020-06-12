Plug 'dyng/ctrlsf.vim'

" ------------------------------ ctrlsf ----------------------------
" nmap     <C-f> <Plug>CtrlSFCwordPath
command -nargs=+ Search CtrlSF <args>
vmap     <C-f> <Plug>CtrlSFVwordPath
nnoremap <leader>f :CtrlSFToggle<CR>
