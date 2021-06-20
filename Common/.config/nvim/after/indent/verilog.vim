" Version: 1.1
"
" this file is from https://www.vim.org/scripts/script.php?script_id=5040

" -----------------------------------------------------------------------
" Make script work with vim
" -----------------------------------------------------------------------

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    "  finish
endif
let b:did_indent = 1

" Only define the function once.
if exists("*GetVerilogIndent")
    "  finish
endif

setlocal indentexpr=GetVerilogIndent()
setlocal indentkeys=!^F,o,O,0),=begin,=end
setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal smarttab

set cpo-=C

function! GetVerilogIndent()

    if exists('b:verilog_indent_verbose')
        let vverb = 1
    else
        let vverb = 0
    endif
    let vverb_str = 'INDENT VERBOSE:'

    if exists('b:verilog_indent_width')
        let offset = b:verilog_indent_width
    else
        let offset = &sw
    endif

    " -----------------------------------------------------------------------
    " Set keywords and identifiers
    " -----------------------------------------------------------------------

    let block_open    = '\(:\s*$\|foreach\|repeat\|reg\|wire\|logic\|while\|always_comb\|always_ff\|if\|else\|@\|always\|initial\)' "Do not inclue for (handled separately)
    let section_open  = '\(class\|package\|clocking\|interface\|`ifdef\|`ifndef\|`elsif\|`else\|module\|task\|function\|generate\|case\%[[zx]]\|specify\|fork\)'
    let section_close = '\(endclass\|endpackage\|endclocking\|endinterface\|`endif\|`elsif\|`else\|endmodule\|endtask\|endfunction\|endgenerate\|endcase\|endspecify\|join_none\|join_all\|join_any\|join\)'
    let list_open     = '\({\|(\|#\s*(\)'
    let list_close    = '\()\|}\)'
    let list_continue = '\(,\|&\||\|or\|+\|-\)'
    let postfix       = '\(' . list_open . '\|:\|@\|\s\|$\)' "To make sure words like tasker and form don't get opening indents
    let prefix        = '\(^\|\s\|:\)' " :begin is possible for case statements
    let anything      = '\s.*\s'
    let line_start    = '^\s*'

    " -----------------------------------------------------------------------
    " Get previous/current line numbers and contents
    " -----------------------------------------------------------------------

    " Find a non-blank line above the current line.
    let lnum = prevnonblank(v:lnum - 1)

    "treat comments as blank lines
    while lnum > 0 && getline(lnum) =~ '^\s*\(\/\/\|\*\)'
        let lnum = prevnonblank(lnum - 1)
    endwhile

    " At the start of the file use zero indent.
    if lnum == 0
        return 0
    endif

    " Find a non-blank line above the last line.
    let lnum2 = prevnonblank(lnum - 1)

    "treat comments as blank lines
    while lnum2 > 0 && getline(lnum2) =~ '^\s*\(\/\/\|\*\)'
        let lnum2 = prevnonblank(lnum2 - 1)
    endwhile

    let curr_line  = getline(v:lnum)
    let last_line  = getline(lnum)
    let last_line2 = getline(lnum2)
    let ind  = indent(lnum)
    let ind2 = indent(lnum - 1)
    let offset_comment1 = 0

    "remove strings and comments (keywords get caught in those)
    "also remove inner braces and bracket sets
    "must replace with non-blank to show that something was there
    let curr_line = substitute(curr_line   , "\/\/.*"       , ""      , "") "comment
    let curr_line = substitute(curr_line   , "\/[*].*[*]\/" , ""      , "") "comment
    let curr_line = substitute(curr_line   , "\/[*].*"      , ""      , "") "comment
    let curr_line = substitute(curr_line   , "\".*.\""      , " sdf " , " sdf ") "string
    let curr_line = substitute(curr_line   , "{[^{}]*}"     , " sdf " , " sdf ") "brackets
    let curr_line = substitute(curr_line   , "([^()]*)"     , " sdf " , " sdf ") "braces

    let last_line = substitute(last_line   , "\/\/.*"       , ""      , "") "comment
    let last_line = substitute(last_line   , "\/[*].*[*]\/" , ""      , "") "comment
    let last_line = substitute(last_line   , "\/[*].*"      , ""      , "") "comment
    let last_line = substitute(last_line   , "\".*.\""      , " sdf " , " sdf ") "string
    let last_line = substitute(last_line   , "{[^{}]*}"     , " sdf " , " sdf ") "brackets
    let last_line = substitute(last_line   , "([^()]*)"     , " sdf " , " sdf ") "brackets

    let last_line2 = substitute(last_line2 , "\/\/.*"       , ""      , "") "comment
    let last_line2 = substitute(last_line2 , "\/[*].*[*]\/" , ""      , "") "comment
    let last_line2 = substitute(last_line2 , "\/[*].*"      , ""      , "") "comment
    let last_line2 = substitute(last_line2 , "\".*.\""      , " sdf " , " sdf ") "string
    let last_line2 = substitute(last_line2 , "{[^{}]*}"     , " sdf " , " sdf ") "brackets
    let last_line2 = substitute(last_line2 , "([^()]*)"     , " sdf " , " sdf ") "braces

    " -----------------------------------------------------------------------
    " Indent rules based on last_line
    " -----------------------------------------------------------------------

    " Indent after section opener
    if last_line =~ prefix . section_open . postfix

        " Do nothing if the section is immediately closed
        if last_line !~ prefix . section_open . anything . section_close . postfix
            let ind = ind + offset
            if vverb | echo vverb_str "Indent after section statement." | endif
        else
            if vverb | echo vverb_str "Do not indent after this section statement." | endif
        endif

        " Indent after block opener
    elseif last_line =~ prefix . block_open . postfix

        " Do nothing if the block is immediately closed or starts with begin
        if last_line !~ prefix . 'begin' . anything . 'end' . postfix &&
                    \ last_line !~ prefix . 'output\s*' . block_open . '\s.*' &&
                    \ last_line !~ prefix .  'input\s*' . block_open . '\s.*' &&
                    \ last_line !~ '.*;' && curr_line !~ line_start . 'begin\s*$'
            let ind = ind + offset
            if vverb | echo vverb_str "Indent after a block statement." | endif
        else
            if vverb | echo vverb_str "Do not indent after this block statement." | endif
        endif


        " Indent after a 'begin' statement
    elseif last_line =~ prefix . 'begin' . postfix

        if last_line !~ prefix . 'begin' . anything . 'end' . postfix
            let ind = ind + offset
            if vverb | echo vverb_str "Indent after a begin statement." | endif
        else
            if vverb | echo vverb_str "Do not indent after this begin statement." | endif
        endif

        " Indent after for block opener (these are special)
    elseif last_line =~ prefix . 'for' . postfix

        " Do nothing if the for is immediately closed: for() ... ;
        if last_line !~ ').*;' && curr_line !~ line_start . 'begin\s*$'
            let ind = ind + offset
            if vverb | echo vverb_str "Indent after a for statement." | endif
        else
            if vverb | echo vverb_str "Do not indent after this for statement." | endif
        endif

        " Indent after list opener
    elseif last_line =~ list_open

        if last_line !~ list_open . '.*' . list_close
            let ind = ind + offset
            if vverb | echo vverb_str "Indent after a list opener." | endif
        else
            if vverb | echo vverb_str "No indent since list was closed immediately." | endif
        endif

    else
        if vverb | echo vverb_str "Nothing to do" | endif

    endif

    " -----------------------------------------------------------------------
    " De-indent rules based on last_line2
    " -----------------------------------------------------------------------

    if last_line2 =~ prefix . 'begin' . postfix
        if vverb | echo vverb_str "Begin blocks one-line block de-indenting" | endif

        " De-indent for the end of one-line block
    elseif last_line2 =~ prefix . block_open . postfix
                \ && last_line =~ ';'

        "if() ... ; does not produce an indent, so don't de-indent
        if last_line2 !~ ';'
            let ind = ind - offset
            if vverb | echo vverb_str "De-indent after the end of one-line statement." | endif
        else
            if vverb | echo vverb_str "Do not de-indent after this one-line statement." | endif
        endif

        " De-indent for the end of one-line for
    elseif last_line2 =~ line_start . 'for' . postfix
                \ && last_line =~ ';'

        " Do nothing if the for is immediately closed: for() ... ;
        if last_line2 !~ ').*;'
            let ind = ind - offset
            if vverb | echo vverb_str "De-indent after the end of one-line for loop." | endif
        else
            if vverb | echo vverb_str "Do not indent after this one-line for loop." | endif
        endif

        " De-indent for a list with a closer on the last line of list
    elseif (last_line2 =~ list_continue . '\s*$' || last_line2 =~ list_open . '\s*$') &&
                \ last_line =~ list_close . '\(;\|\s*$\)'

        let ind = ind - offset
        if vverb | echo vverb_str "De-indent after a quick closing list." | endif
    endif

    " -----------------------------------------------------------------------
    " De-indentation rules based on curr_line
    " -----------------------------------------------------------------------

    " De-indent on the end of a begin block
    if curr_line =~ prefix . 'end' . postfix

        " Don't de-indent for one line blocks
        if curr_line !~ prefix . 'begin' . anything . 'end' . postfix
            let ind = ind - offset
            "if vverb | echo vverb_str "De-indent the end of a block." | endif
        else
            if vverb | echo vverb_str "Do not de-indent the end of this block." | endif
        endif

        " De-indent on the end of a section
    elseif curr_line =~ prefix . section_close . postfix

        " Don't de-indent for one line sections
        if curr_line !~ prefix . section_open . anything . section_close . postfix
            let ind = ind - offset
            if vverb | echo vverb_str "De-indent the end of a section." | endif
        else
            if vverb | echo vverb_str "Do not de-indent the end of this section." | endif
        endif

        " De-indent after a list close
    elseif curr_line =~ line_start . list_close

        let ind = ind - offset
        if vverb | echo vverb_str "De-indent the end of a list." | endif

    endif

    " Return the indention
    return ind
endfunction

