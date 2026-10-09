local function config()
  local launcher
  if vim.fn.has('mac') == 1 then
    launcher = "open"
  elseif vim.fn.has('linux') == 1 then
    launcher = "evince"
  end

  local listings_setup = vim.fs.dirname(debug.getinfo(1, 'S').source:gsub('^@', '')).."/listings_setup.tex"

  vim.g.knap_settings = {
    mdoutputext = "pdf",
    mdtopdf = string.format("pandoc -f markdown-smart+hard_line_breaks --listings -H %s -o %%outputfile%% --pdf-engine=lualatex -V documentclass=ltjsarticle -V 'mainfont: Noto serif' -V geometry:margin=1.5cm", listings_setup),
    mdtopdfviewerlaunch = launcher.." %outputfile%",
    mdtopdfviewerrefresh = "none",
    mdtopdfbufferasstdin = true,
  }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "pandoc", "md" },
    callback = function()
      vim.keymap.set("n", "<leader>kt", function()
        require("knap").toggle_autopreviewing()
      end, { buffer = true, desc = "KNAP toggle auto-preview" })
    end,
  })
end

return {
  {
    "frabjous/knap",
    lazy = false,
    config = config,
  },
}

