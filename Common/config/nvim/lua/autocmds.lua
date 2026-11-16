vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*Xresources.d/*',
  command = 'setlocal filetype=xdefaults'
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = 'zprofile',
  command = 'setlocal filetype=zsh'
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'WinEnter', 'Filetype' }, {
  pattern = { "markdown", "tex", "gitcommit", "c" },
  callback = function()
    -- Disable spelling in floating/popup windows (LSP hover, diagnostics float, etc.)
    local winconf = vim.api.nvim_win_get_config(0)
    if winconf.relative ~= "" then
      vim.opt_local.spell = false
      return
    end

    -- Otherwise enable spelling
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us,cjk"
  end,
})
