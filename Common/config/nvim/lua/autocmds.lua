vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*Xresources.d/*',
  command = 'setlocal filetype=xdefaults'
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = 'zprofile',
  command = 'setlocal filetype=zsh'
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'Filetype' }, {
  pattern = { 'markdown', 'tex', 'gitcommit' },
  command = 'setlocal spell spelllang=en_us'
})
