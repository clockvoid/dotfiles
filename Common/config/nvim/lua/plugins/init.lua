vim.cmd.runtime('ftplugin/man.vim')

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

require('lazy').setup({
  require('plugins/lsp'),
  require('plugins/fzf'),
  require('plugins/colorscheme'),
  require('plugins/vim-latex'),
  require('plugins/previm'),
  require('plugins/quickrun'),

  { 'simeji/winresizer' },
  { 'maxmellon/vim-jsx-pretty',  ft = { 'javascript', 'typescript' } },
  { 'neovimhaskell/haskell-vim', ft = { 'haskell' } },
  { 'scrooloose/syntastic',      ft = { 'swift' } },
  { 'keith/swift.vim',           ft = { 'swift' } },
  { 'udalov/kotlin-vim',         ft = { 'kotlin' } },
}, {
  ui = {
    icons = {
      cmd = "💾",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    }
  }
})
