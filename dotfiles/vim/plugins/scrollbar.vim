Plug 'Xuyuanp/scrollbar.nvim'

let g:scrollbar_max_size = 15
let g:scrollbar_highlight = {
      \ 'head': 'Comment',
      \ 'body': 'Comment',
      \ 'tail': 'Comment',
      \ }
let g:scrollbar_excluded_filetypes = ['nerdtree', 'tagbar']

augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,FocusLost             * silent! lua require('scrollbar').clear()
  autocmd BufLeave,BufNew,VimResized,QuitPre               * silent! lua require('scrollbar').clear()
augroup end
