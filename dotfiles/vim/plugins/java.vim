Plug 'uiiaoo/java-syntax.vim'
Plug 'keitokuch/vim-junit-jump'

let g:syntastic_java_checkers = ['checkstyle']
let g:syntastic_java_checkstyle_classpath = '~/.vim/checkstyle-8.7-all.jar'
let g:syntastic_java_checkstyle_conf_file = './config/checkstyle/checkstyle.xml'

nnoremap gt :JavaJUnitJump<CR>

au filetype java map <leader>ji :call CocActionAsync('organizeImport')<CR>:echo 'imports organized'<CR>

hi link javaIdentifier NONE
