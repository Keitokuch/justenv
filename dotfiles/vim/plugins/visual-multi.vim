Plug 'mg979/vim-visual-multi'

" ------------------------- vim-visual-multi -------------------------
let g:VM_theme = 'ocean'
nmap   <S-LeftMouse>         <Plug>(VM-Mouse-Cursor)
nmap   <S-RightMouse>        <Plug>(VM-Mouse-Word)
nmap   <S-C-RightMouse>      <Plug>(VM-Mouse-Column)
let g:VM_maps = {}
let g:VM_maps["Switch Mode"]        = 'v'
let g:VM_maps['Find Under']         = '<C-n>'
let g:VM_maps["Add Cursor Down"]    = '<S-Down>'
let g:VM_maps["Add Cursor Up"]      = '<S-Up>'
let g:VM_maps["Remove Region"]      = 'x'
let g:VM_maps["x"]                  = ''
let g:VM_maps["Skip Region"]        = '<C-x>'
let g:VM_maps["Undo"]               = 'u'
let g:VM_maps["Redo"]               = '<C-r>'
let g:VM_maps["Add Cursor At Pos"]  = '+'
