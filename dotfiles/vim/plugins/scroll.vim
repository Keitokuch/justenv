Plug 'psliwka/vim-smoothie'

let g:smoothie_no_default_mappings = 1
let g:smoothie_update_interval = 8
let g:smoothie_base_speed = 10

silent! nmap <C-d>      12<Plug>(SmoothieDownwards)
silent! nmap <C-i>      12<Plug>(SmoothieUpwards)
