Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp', 'cuda'] }

" ----------------------- cpp-enhanced-highlight ------------------------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
hi def link cCustomMemVar           Identifier
hi def link cCustomPtr              Operator
hi def link cFormat                 Type
