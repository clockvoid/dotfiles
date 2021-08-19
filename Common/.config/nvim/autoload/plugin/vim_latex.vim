
function! plugin#vim_latex#hook_source() abort

    ""
    "" Vim-LaTeX
    ""
    "filetype plugin on
    "filetype indent on
    set shellslash
    set grepprg=grep\ -nH\ $*
    let g:tex_flavor='latex'
    let g:Imap_UsePlaceHolders = 1
    let g:Imap_DeleteEmptyPlaceHolders = 1
    let g:Imap_StickyPlaceHolders = 1
    let g:Tex_DefaultTargetFormat = 'pdf'
    let g:Tex_MultipleCompileFormats='dvi,pdf'
    "let g:Tex_FormatDependency_pdf = 'pdf'
    let g:Tex_FormatDependency_pdf = 'dvi,pdf'
    "let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
    let g:Tex_FormatDependency_ps = 'dvi,ps'
    "let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
    let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
    "let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
    let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    "let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    let g:Tex_CompileRule_dvi = 'platex --shell-escape $*.tex'
    let g:Tex_BibtexFlavor = 'upbibtex'
    let g:Tex_MakeIndexFlavor = 'upmendex $*.idx'
    let g:Tex_UseEditorSettingInDVIViewer = 1
    "let g:Tex_ViewRule_pdf = 'xdg-open'
    let g:Tex_ViewRule_pdf = 'open -a skim'
    "let g:Tex_ViewRule_pdf = 'okular --unique'
    "let g:Tex_ViewRule_pdf = 'zathura -x "vim --servername synctex -n --remote-silent +\%{line} \%{input}"'
    "let g:Tex_ViewRule_pdf = 'qpdfview --unique'
    "let g:Tex_ViewRule_pdf = 'texworks'
    "let g:Tex_ViewRule_pdf = 'mupdf'
    "let g:Tex_ViewRule_pdf = 'firefox -new-window'
    "let g:Tex_ViewRule_pdf = 'chromium --new-window'
    "let g:Tex_ViewRule_pdf = 'open evince'
endfunction
