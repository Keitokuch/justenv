" ============================ Key Mappings =============================
let mapleader=" "
"" jj to exit insert mode
inoremap jj <ESC>
"" Use q for escape
map q <ESC>
nnoremap Q q
"" Up Down scrolling
map <C-i> 10k
map <C-d> 10j
"" Copy All
nnoremap Y :%y<CR>
"" <space>= Indent All
nnoremap <leader>= gg=G<C-o>
"" Sudo Write
command Sudow w !sudo dd of=%
cmap w!! w !sudo -S tee%

"" Split
map s <nop>
map S <nop>
map s_ :set splitbelow<CR>:split<CR>
map s\| :set splitright<CR>:vsplit<CR>
map <leader>l <C-w>l
map <leader>h <C-w>h
map <leader>k <C-w>k
map <leader>j <C-w>j
map <leader>p <C-w>p
" map sl :set splitright<CR>:vsplit<CR>
" map sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
" map sj :set splitbelow<CR>:split<CR>
" map sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>

" Use <Meta-Arrow> or <Space><Arrow> to resize split window
map <M-Up> :resize +5<CR>
map <M-Down> :resize -5<CR>
map <M-Left> :vertical resize-5<CR>
map <M-Right> :vertical resize+5<CR>
map <leader><Up> :resize +5<CR>
map <leader><Down> :resize -5<CR>
map <leader><Left> :vertical resize-5<CR>
map <leader><Right> :vertical resize+5<CR>

"" Tab
" map <leader>t :tabe<CR>
" map <leader>] :+tabnext<CR>
" map <leader>[ :-tabnext<CR>

"" <Space s> to save
map <leader>s :SaveFile<CR>
"" <Space q> to quit
map <leader>q :qall<CR>
"" <Space Q> to force quit
map <leader>Q :qall!<CR>
"" <Space w> to close file
" map <silent><expr> <leader>w buflisted(bufnr("%"))? ":bp<cr>:bd #<cr>" : ":q\<CR>"
map <leader>w :CloseBuffer<CR>
"" <Space W> to force close file
map <silent><expr> <leader>W buflisted(bufnr("%"))? ":bp<cr>:bd! #<cr>" : ":q!\<CR>"
"" <Space Ctrl-W> to close window
map <leader><C-w> :q<CR>

"" Jumping
" <Ctrl-P> jump to tag
nnoremap <C-p> <C-]>
" Redo jump
nnoremap <C-u> <C-i>
" jump last tag
nnoremap <C-y> <C-t>

"" Insert mode emacs bindings
inoremap <C-a> <ESC>I
inoremap <C-f> <right>
inoremap <C-b> <left>
inoremap <C-M-b> <ESC>bi
inoremap <C-M-f> <right><ESC>wi
inoremap <C-M-d> <right><ESC>wcw
inoremap <silent><expr> <C-e> pumvisible()? "\<C-e>" : "\<ESC>A"
inoremap <silent><expr> <C-p> pumvisible()? "\<C-p>" : "\<up>"
inoremap <silent><expr> <C-n> pumvisible()? "\<C-n>" : "\<down>"

"" Terminal mode
" QQ to escape in terminal
tnoremap QQ     <C-\><C-n>
tnoremap <Esc>  <C-\><C-n>

" Minimal auto closing
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "''<left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"<left>""
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
