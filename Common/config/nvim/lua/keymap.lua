vim.api.nvim_set_keymap('v', '<C-s>y', '"+y', {})
vim.api.nvim_set_keymap('v', '<C-s>d', '"+d', {})
vim.api.nvim_set_keymap('n', '<C-s>p', '"+p', {})
vim.api.nvim_set_keymap('n', '<C-s>P', '"+P', {})
vim.api.nvim_set_keymap('v', '<C-s>p', '"+p', {})
vim.api.nvim_set_keymap('v', '<C-s>P', '"+P', {})

vim.api.nvim_set_keymap('n', '<C-s>"', 'ciw""<Esc>P', { noremap = true })
vim.api.nvim_set_keymap('n', "<C-s>'", "ciw''<Esc>P", { noremap = true })
vim.api.nvim_set_keymap('n', '<C-s>`', 'ciw``<Esc>P', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-s>(', 'ciw()<Esc>P', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-s>{', 'ciw{}<Esc>P', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-s>[', 'ciw[]<Esc>P', { noremap = true })

vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })
vim.api.nvim_set_keymap('v', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('v', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('v', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('v', 'gk', 'k', { noremap = true })

vim.api.nvim_set_keymap('x', 'p', "'pgv\"'.v:register.'y`>'", { noremap = true, expr = true })
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { silent = true, noremap = true })

vim.diagnostic.config({
  float = {
    border = 'rounded',
    focusable = false,
  }
})
local function jump_to_diagnostics_in_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local lnum = cursor[1] - 1

  local diags = vim.diagnostic.get(0, { lnum = lnum })
  if #diags == 0 then return end

  table.sort(diags, function(a, b) return a.col < b.col end)

  -- first diagnostic strictly after the cursor; wrap to the first if none
  local target = diags[1]
  for _, d in ipairs(diags) do
    if d.col > cursor[2] then
      target = d
      break
    end
  end

  vim.diagnostic.jump({ diagnostic = target, float = true })
end
-- With xterm styled sequence, <S-F1> turned into <F13>
vim.keymap.set('n', '<F13>', jump_to_diagnostics_in_current_line)
vim.keymap.set('n', '<S-F1>', jump_to_diagnostics_in_current_line)
vim.keymap.set('n', '<F2>', function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set('n', '<S-F2>', function()
  vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set('n', '<M-6>', vim.diagnostic.setloclist)

