local function config()
  local launcher
  if vim.fn.has('mac') == 1 then
    launcher = "open"
  elseif vim.fn.has('linux') then
    launcher = "evince"
  end

  vim.g.knap_settings = {
    mdoutputext = "pdf",
    mdtopdf = "pandoc -f markdown-smart -o %outputfile% --pdf-engine=lualatex -V documentclass=ltjsarticle -V 'mainfont: Noto serif' -V geometry:margin=1.5cm",
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

