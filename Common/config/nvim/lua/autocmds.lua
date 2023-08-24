vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*Xresources.d/*',
    command = 'setlocal filetype=xdefaults'
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = 'zprofile',
    command = 'setlocal filetype=zsh'
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.json',
    command = 'setlocal foldmethod=syntax'
})
