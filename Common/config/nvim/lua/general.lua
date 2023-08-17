vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = 'utf-8,sjis,euc-jp,iso-2022-jp'
vim.opt.fileformats = 'unix,dos,mac'
vim.cmd.lang('mes', 'C')

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.number = true
vim.opt.cmdheight = 2
vim.opt.showcmd = true
vim.opt.title = true
vim.opt.statusline:append('%F')

vim.cmd.syntax('on')
vim.cmd.filetype('plugin', 'indent', 'on')

vim.opt.ttimeoutlen = 10

vim.opt.wildmenu = true
vim.opt.wildmode = 'full'
vim.opt.wildignorecase = true

vim.opt.conceallevel = 0
vim.opt.concealcursor = ''

vim.g.markdown_folding = 1
