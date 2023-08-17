vim.opt.background = 'dark'
vim.cmd([[ 
if !has('gui_runnig')
    set t_Co=256
endif
]])
vim.g.hybrid_custom_term_colors = 1

local function hook_add_lightline()
    vim.g.lightline = {
        colorscheme = 'hybrid',
        separator = {
            left = '',
            right = ''
        },
        subseparator = {
            left = '',
            right = ''
        },
    }
end

local function hook_add_hybrid()
    vim.cmd.colorscheme('hybrid')
    vim.opt.cursorline = true
    vim.cmd.highlight('LineNr', 'ctermfg=lightgray')
    vim.cmd.highlight('CursorLine', 'cterm=none', 'ctermfg=none', 'ctermbg=none', 'guifg=none', 'guibg=none')
    vim.cmd.highlight('CursorLineNr', 'ctermfg=white')
    vim.cmd.highlight('MatchParen', 'ctermbg=237', 'ctermfg=255', 'guibg=#3a3a3a', 'guifg=#eeeeee')
end

return {
    {
        'w0ng/vim-hybrid',
        config = hook_add_hybrid
    },
    { 'cocopon/lightline-hybrid.vim' },
    {
        'itchyny/lightline.vim',
        config = hook_add_lightline,
        dependencies = {
            'lightline-hybrid.vim',
            'w0ng/vim-hybrid'
        },
    }
}
