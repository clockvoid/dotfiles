vim.g.tex_flavor = 'latex'

local function set_tex_family()
    local function setLuaLaTex()
        vim.g.Tex_MultipleCompileFormats = 'pdf,bibtex,pdf'
        vim.cmd([[ 
        if exists('g:Tex_FormatDependency_pdf')
            unlet g:Tex_FormatDependency_pdf
        endif
        ]])
        vim.g.Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        vim.cmd([[
        if exists('g:Tex_CompileRule_dvi')
            unlet g:Tex_CompileRule_dvi
        endif
        ]])
        vim.b.is_lua_latex = 1
        print("lualatex mode")
    end

    local function setPLaTex()
        vim.g.Tex_MultipleCompileFormats='dvi,pdf,bibtex,pdf'
        vim.g.Tex_FormatDependency_pdf = 'dvi,pdf'
        vim.g.Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
        vim.g.Tex_CompileRule_dvi = 'platex --shell-escape $*.tex'
        --vimg.Tex_CompileRule_dvi = 'uplatex $*.tex'
        --vim.g.Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        vim.b.is_lua_latex = 0
        print("platex mode")
    end

    local function auto_set()
        --vim.bo.shellslash = true
        vim.bo.grepprg = 'grep -nH $*'

        local function ToggleTexFlavor()
            if vim.b.is_lua_latex == 1 then
                setPLaTex()
            else
                setLuaLaTex()
            end
        end

        vim.keymap.set('n', '<C-l>', ToggleTexFlavor, {buffer = true, noremap = true})

        vim.b.filename = vim.fn.fnamemodify(vim.fn.expand('%:r'), ':t:r')
        if vim.b.filename == 'slide' then
            setLuaLaTex()
        else
            setPLaTex()
        end
    end

    vim.api.nvim_create_autocmd('BufEnter', {
        pattern = '*.tex',
        callback = auto_set
    })
end

local function hook_source()
    vim.g.Imap_UsePlaceHolders = 1
    vim.g.Imap_DeleteEmptyPlaceHolders = 1
    vim.g.Imap_StickyPlaceHolders = 1
    vim.g.Tex_DefaultTargetFormat = 'pdf'
    vim.g.Tex_BibtexFlavor = 'biber'
    vim.g.Tex_MakeIndexFlavor = 'upmendex $*.idx'
    vim.g.Tex_UseEditorSettingInDVIViewer = 1

    vim.cmd([[
        if has("mac")
            let g:Tex_ViewRule_pdf = 'open -a skim'
        endif
        if executable("evince")
            let g:Tex_ViewRule_pdf = 'evince'
        endif
    ]])

    vim.g.Tex_IgnoredWarnings = [[
Underfull
Overfull
Using fall-back BibTeX(8) backend
Package caption Warning
LaTeX hooks Warning
Package fontspec Warning
Package pgf Warning
LaTeX Font Warning:
Label(s) may have changed.
Citation %.%# undefined
    ]]
    vim.g.Tex_IgnoreLevel = 8
    vim.g.Tex_FoldedEnvironments = ',frame'

    set_tex_family()
end

return {
    {
        'vim-latex/vim-latex',
        ft = { 'tex' },
        config = hook_source()
    },
}
