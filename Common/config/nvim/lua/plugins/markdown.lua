local function enable_knap()
  if vim.fn.executable('pandoc') == 0 then
    return
  end
  if vim.fn.executable('lualatex') == 0 then
    return
  end

  local launcher
  if vim.fn.has('mac') == 1 then
    launcher = "open"
  elseif vim.fn.has('linux') == 1 then
    launcher = "evince"
  end

  local listings_setup = vim.fs.dirname(debug.getinfo(1, 'S').source:gsub('^@', '')).."/listings_setup.tex"

  vim.b.knap_settings = {
    mdoutputext = "pdf",
    mdtopdf = string.format("pandoc -f markdown-smart+hard_line_breaks --listings -H %s -o %%outputfile%% --pdf-engine=lualatex -V documentclass=ltjsarticle -V 'mainfont: Noto serif' -V geometry:margin=1.5cm", listings_setup),
    mdtopdfviewerlaunch = launcher.." %outputfile%",
    mdtopdfviewerrefresh = "none",
    mdtopdfbufferasstdin = true,
  }

  vim.keymap.set("n", "<leader>lv", function()
    require("knap").toggle_autopreviewing()
  end, { buffer = true, desc = "KNAP toggle auto-preview" })

  vim.keymap.set("n", "<leader>ll", function ()
    require("knap").process_once()
  end, { buffer = true, desc = "KNAP onetime execution" })
end

local function config()
  vim.g.knap_settings = {
    delay = 5,
  }

  vim.api.nvim_create_autocmd({ 'BufEnter', 'Filetype' }, {
    pattern = { 'markdown', 'pandoc' },
    callback = function ()
      enable_knap()
      if not(vim.b.knap_autopreviewing) then
        require("knap").toggle_autopreviewing()
      end
    end
  })
end

return {
  {
    "frabjous/knap",
    ft = { 'markdown', 'pandoc' },
    config = config,
  },
}

