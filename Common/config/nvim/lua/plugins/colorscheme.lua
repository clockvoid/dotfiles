return {
  {
    'RRethy/nvim-base16',
    config = function()
      vim.cmd.colorscheme('base16-tomorrow-night')
      vim.opt.termguicolors = true
      vim.opt.background = 'dark'
      vim.opt.cursorline = true
      vim.cmd.highlight('LineNr', 'ctermfg=gray', 'guifg=#707880')
      vim.cmd.highlight('CursorLineNr', 'ctermfg=white', 'guifg=#c5c8c6')
      vim.cmd.highlight('CursorLineSign', 'guibg=#282a2e')
      vim.cmd.highlight('MatchParen', 'ctermbg=237', 'ctermfg=255', 'guibg=#3a3a3a', 'guifg=#eeeeee')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'base16',
          icons_enabled = false,
        },
      }
    end,
  }
}

