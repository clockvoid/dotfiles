local function hook_source()
  if vim.fn.has('mac') == 1 then
    vim.g.previm_open_cmd = 'open -a "Google Chrome"'
  elseif string.match(vim.fn.system('uname'), 'Linux') then
    vim.g.previm_open_cmd = 'firefox'
  end

  vim.g.previm_hard_line_break = 1
  vim.g.previm_enable_realtime = 1
  vim.g.previm_code_language_show = 1
end

return {
  {
    'kannokanno/previm',
    config = hook_source,
    ft = { 'markdown' },
  }
}

