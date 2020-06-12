" ================== Utils ===================
" Syntax Stack
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <C-g> :call <SID>SynStack()<CR>

fu! StartSetup()
    if (argc() == 0 && !exists("s:std_in"))
        let g:DIR_START = 1
        if !RestoreSess()
            exe 'NERDTreeToggle'
        endif
    elseif argc() == 1 && isdirectory(argv()[0]) == 1 && !exists("s:std_in")
        let g:DIR_START = 1
        exe 'cd ' . argv()[0]
        if !RestoreSess()
            exe 'NERDTreeToggle' argv()[0] | wincmd p | ene
        endif
    else
        let g:DIR_START=0
    endif
endfu

fu! RestoreSess()
    if filereadable(getcwd() . '/.Session.vim')
        exe 'so ' . getcwd() . '/.Session.vim'
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    exe 'sbuffer ' . l
                endif
            endfor
        endif
        exe 'NERDTreeFind' | wincmd p
        return 1
    else
        return 0
    endif
endfunction

fu! LeaveSetup()
    let currTab = tabpagenr()
    tabdo helpclose
    if exists('g:loaded_nerd_tree') | tabdo NERDTreeClose
    endif
    if exists('g:loaded_vterm') | tabdo VTermClose
    endif
    if exists('g:loaded_tagbar') | tabdo TagbarClose
    endif
    exe 'tabn ' . currTab
    mksession! ./.Session.vim
endfu

function! MyTabline()
    " let tabline=buffet#render()
    let tabline=airline#extensions#tabline#get()
    if g:NERDTree.IsOpen()
        let width = winwidth(g:NERDTree.GetWinNum())
        let tabline = '%#Normal#' . repeat(' ', width) . '%#VertSplit# ' . tabline
    endif
    return tabline
endfunction

function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
command -nargs=0 StripTrailingSpaces call StripTrailingWhitespaces()
