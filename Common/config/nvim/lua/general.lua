vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = 'utf-8,sjis,euc-jp,iso-2022-jp'
vim.opt.fileformats = 'unix,dos,mac'
vim.cmd.lang('mes', 'C')

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.markdown_recommended_style = 0

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
