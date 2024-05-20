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
  vim.g.hybrid_custom_term_colors = 1
  vim.opt.termguicolors = false
  vim.opt.background = 'dark'
  vim.cmd.colorscheme('hybrid')
  vim.opt.cursorline = true
  vim.cmd.highlight('LineNr', 'ctermfg=lightgray', 'guifg=lightgray')
  vim.cmd.highlight('CursorLine', 'cterm=none', 'ctermfg=none', 'ctermbg=none', 'guifg=none', 'guibg=none')
  vim.cmd.highlight('CursorLineNr', 'ctermfg=white', 'guifg=white')
  vim.cmd.highlight('MatchParen', 'ctermbg=237', 'ctermfg=255', 'guibg=#3a3a3a', 'guifg=#eeeeee')
  vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Pmenu' })
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
