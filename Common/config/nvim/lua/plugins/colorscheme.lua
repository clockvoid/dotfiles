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
  vim.g.hybrid_custom_term_colors = 0
  vim.opt.termguicolors = true
  vim.opt.background = 'dark'
  vim.cmd.colorscheme('hybrid')
  vim.opt.cursorline = true
  vim.cmd.highlight('LineNr', 'ctermfg=lightgray', 'guifg=#707880')
  vim.cmd.highlight('CursorLine', 'cterm=none', 'ctermfg=none', 'ctermbg=none', 'guifg=none', 'guibg=none')
  vim.cmd.highlight('CursorLineNr', 'ctermfg=white', 'guifg=#c5c8c6')
  vim.cmd.highlight('MatchParen', 'ctermbg=237', 'ctermfg=255', 'guibg=#3a3a3a', 'guifg=#eeeeee')
  vim.cmd.highlight('NormalFloat', 'guibg=#1d1f21')
  vim.cmd.highlight('FloatBorder', 'guibg=#1d1f21')
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
