local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd.runtime('ftplugin/man.vim')

return require('lazy').setup({
    require('plugins/lsp'),
    require('plugins/fzf'),
    require('plugins/hybrid'),
    require('plugins/vim-latex'),
    require('plugins/previm'),
    require('plugins/quickrun'),

    { 'simeji/winresizer' },
    { 'neovimhaskell/haskell-vim', ft = { 'haskell' } },
    { 'scrooloose/syntastic', ft = { 'swift' } },
    { 'keith/swift.vim', ft = { 'swift' } },
})
