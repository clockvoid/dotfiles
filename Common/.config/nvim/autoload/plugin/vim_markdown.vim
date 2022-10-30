
function! plugin#vim_markdown#hook_add() abort

    " disable markdown conceal
    let g:vim_markdown_conceal = 0

    " disable math conceal in markdown
    let g:vim_markdown_math = 1

    " disable conceal code blocks
    let g:vim_markdown_conceal_code_blocks = 0

    " enable yaml syntax in front of markdown file
    let g:vim_markdown_frontmatter = 1

    " disable auto insert indentation
    let g:vim_markdown_new_list_item_indent = 0
    let g:vim_markdown_auto_insert_bullets = 0
endfunction
