" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
"

" let g:pymode_python = 'python3'
" let g:pymode_rope = 0
" let g:pymode_warnings = 1
" let g:pymode_syntex = 1
" let g:pymode_syntex_all = 1
" let g:pymode_syntax_space_errors = 0
" let g:pymode_trim_whitespaces = 1
" let g:pymode_motion = 1
" let g:pymode_lint_checkers = ['pep8']
" let g:pymode_lint_cwindow = 0
" let g:pymode_lint_signs = 0
" let g:pymode_run_bind = '<leader>c'
" let g:pymode_virtualenv = 1
hi def link pythonParam             Identifier
hi def link pythonClassParameters   Identifier
hi def link pythonSelf              Conventional
hi def link pythonOperator          Keyword
hi def link pythonFunction          FunctionDeclaration
hi def link pythonBuiltinFunc       BuiltinFunc
au Filetype python syntax match pythonFunctionCall /\v[[:alpha:]_]+\ze(\s?\()/
hi def link pythonFunctionCall FunctionCall

au BufNewFile,BufRead,BufReadPost *.ejs set syntax=html
