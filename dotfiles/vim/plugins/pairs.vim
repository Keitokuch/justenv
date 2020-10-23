Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

nmap S <Plug>Ysurround
nmap Ss <Plug>Yssurround
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround
xmap s <Plug>VSurround
xmap S <Plug>VSurround
let g:surround_no_insert_mappings = 1

" let g:coc_global_extensions+=['coc-pairs']
