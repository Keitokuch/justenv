Plug 'uiiaoo/java-syntax.vim'

let g:syntastic_java_checkers = ['checkstyle']
let g:syntastic_java_checkstyle_classpath = '~/.vim/checkstyle-8.7-all.jar'
let g:syntastic_java_checkstyle_conf_file = './config/checkstyle/checkstyle.xml'

hi link javaIdentifier NONE
