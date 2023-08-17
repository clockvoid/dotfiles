vim.cmd([[ 
if !has('gui_runnig')
    set t_Co=256
endif
]])

vim.opt.background = 'dark'
vim.cmd.colorscheme('hybrid')
vim.opt.cursorline = true
vim.cmd.highlight('LineNr', 'ctermfg=lightgray')
vim.cmd.highlight('CursorLine', 'cterm=none', 'ctermfg=none', 'ctermbg=none', 'guifg=none', 'guibg=none')
vim.cmd.highlight('CursorLineNr', 'ctermfg=white')
vim.cmd.highlight('MatchParen', 'ctermbg=237', 'ctermfg=255', 'guibg=#3a3a3a', 'guifg=#eeeeee')
