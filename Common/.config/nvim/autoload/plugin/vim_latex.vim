
function! plugin#vim_latex#hook_add() abort
    let g:tex_flavor='latex'
endfunction

function! plugin#vim_latex#hook_source() abort
    ""
    "" Vim-LaTeX
    ""
    let g:Imap_UsePlaceHolders = 1
    let g:Imap_DeleteEmptyPlaceHolders = 1
    let g:Imap_StickyPlaceHolders = 1

    let g:Tex_DefaultTargetFormat = 'pdf'
    let g:Tex_BibtexFlavor = 'biber'
    let g:Tex_MakeIndexFlavor = 'upmendex $*.idx'

    let g:Tex_UseEditorSettingInDVIViewer = 1
    if has("mac")
        let g:Tex_ViewRule_pdf = 'open -a skim'
    endif
    if executable("evince")
        let g:Tex_ViewRule_pdf = 'evince'
    endif
    let g:Tex_IgnoredWarnings = 
                \'Underfull'."\n".
                \'Overfull'."\n".
                \'Using fall-back BibTeX(8) backend'."\n".
                \'Package caption Warning'."\n".
                \'LaTeX hooks Warning'."\n".
                \'Package fontspec Warning'."\n".
                \'Package pgf Warning'."\n".
                \'LaTeX Font Warning:'."\n".
                \'Label(s) may have changed.'."\n".
                \'Citation %.%# undefined'."\n"
    let g:Tex_IgnoreLevel = 8
    let g:Tex_FoldedEnvironments = ',frame'

    call s:set_tex_family()
endfunction

function! s:set_tex_family() abort

    function! s:setLuaLaTex() abort
        let g:Tex_MultipleCompileFormats = 'pdf,bibtex,pdf'
        if exists('g:Tex_FormatDependency_pdf')
            unlet g:Tex_FormatDependency_pdf
        endif
        let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        if exists('g:Tex_CompileRule_dvi')
            unlet g:Tex_CompileRule_dvi
        endif
        let b:is_lua_latex = 1
        echomsg "lualatex mode"
    endfunction

    function! s:setPLaTex() abort
        let g:Tex_MultipleCompileFormats='dvi,pdf,bibtex,pdf'
        let g:Tex_FormatDependency_pdf = 'dvi,pdf'
        let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
        "let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        let g:Tex_CompileRule_dvi = 'platex --shell-escape $*.tex'
        "let g:Tex_CompileRule_dvi = 'uplatex $*.tex'
        let b:is_lua_latex = 0
        echomsg "platex mode"
    endfunction

    function! s:auto_set() abort
        setlocal shellslash
        setlocal grepprg=grep\ -nH\ $*

        function! ToggleTexFlavor() abort
            if b:is_lua_latex
                call s:setPLaTex()
            else
                call s:setLuaLaTex()
            endif
        endfunction

        noremap <buffer> <C-l> :call ToggleTexFlavor()<cr>

        let b:filename = fnamemodify(expand("%:r"), ":t:r")
        if b:filename == "slide"
            call s:setLuaLaTex()
        else
            call s:setPLaTex()
        endif
    endfunction
    autocmd BufEnter *.tex call s:auto_set()
endfunction
