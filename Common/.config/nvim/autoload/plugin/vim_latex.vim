
function! plugin#vim_latex#hook_add() abort
    let g:tex_flavor='latex'
endfunction

function! plugin#vim_latex#hook_source() abort
    ""
    "" Vim-LaTeX
    ""
    set shellslash
    set grepprg=grep\ -nH\ $*
    let g:Imap_UsePlaceHolders = 1
    let g:Imap_DeleteEmptyPlaceHolders = 1
    let g:Imap_StickyPlaceHolders = 1

    let g:Tex_BibtexFlavor = 'upbibtex'
    let g:Tex_MakeIndexFlavor = 'upmendex $*.idx'

    let g:Tex_UseEditorSettingInDVIViewer = 1
    if has("mac")
        let g:Tex_ViewRule_pdf = 'open -a skim'
    endif
    if executable("evince")
        let g:Tex_ViewRule_pdf = 'evince'
    endif
    let g:Tex_IgnoredWarnings = 
                \'LaTeX Font Warning:'."\n".
                \'Underfull'."\n".
                \'Package fontspec Warning'."\n".
                \'Overfull'."\n".
                \'Label(s) may have changed.'
    let g:Tex_IgnoreLevel = 8
    let g:Tex_FoldedEnvironments = ',frame'

    call s:set_tex_family()
endfunction

function! s:set_tex_family() abort

    function! s:setLuaLaTex() abort
        let g:Tex_DefaultTargetFormat = 'pdf'
        "let g:Tex_FormatDependency_pdf = 'pdf'
        let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        let b:is_lua_latex = 1
        echomsg "lualatex mode"
    endfunction

    function! s:setPLaTex() abort
        let g:Tex_DefaultTargetFormat = 'pdf'
        let g:Tex_MultipleCompileFormats='dvi,pdf'
        let g:Tex_FormatDependency_pdf = 'dvi,pdf'
        let g:Tex_FormatDependency_ps = 'dvi,ps'
        let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
        let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
        "let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        let g:Tex_CompileRule_dvi = 'platex --shell-escape $*.tex'
        "let g:Tex_CompileRule_dvi = 'uplatex $*.tex'
        let b:is_lua_latex = 0
        echomsg "platex mode"
    endfunction

    function! s:detect_tex_family() abort
        let b:filename = fnamemodify(expand("%:r"), ":t:r")
        if b:filename == "slide"
            call s:setLuaLaTex()
        else
            call s:setPLaTex()
        endif
    endfunction
    autocmd BufEnter *.tex call s:detect_tex_family()

    function! ToggleTexFlavor() abort
        if b:is_lua_latex
            call s:setPLaTex()
        else
            call s:setLuaLaTex()
        endif
    endfunction
    noremap <silent> <C-l> :call ToggleTexFlavor()<cr>
endfunction
