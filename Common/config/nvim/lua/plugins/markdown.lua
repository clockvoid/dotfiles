local function enable_knap()
  if vim.fn.executable('pandoc') == 0 or vim.fn.executable('lualatex') == 0 then
    return
  end

  local launcher
  if vim.fn.has('mac') == 1 then
    launcher = "open"
  elseif vim.fn.has('linux') == 1 then
    launcher = "evince"
  end

  local listings_setup = vim.fs.dirname(debug.getinfo(1, 'S').source:gsub('^@', '')) .. "/listings_setup.tex"

  vim.b.knap_settings = {
    mdoutputext = "pdf",
    mdtopdf = string.format(
      "pandoc" .. " " ..
      "-M colorlinks" .. " " ..
      "-f markdown" ..
      "-fancy_lists" ..
      "+hard_line_breaks" ..
      "+lists_without_preceding_blankline" ..
      "+emoji" ..
      "-smart" ..
      "+east_asian_line_breaks" ..
      "+autolink_bare_uris" ..
      "+multiline_tables" .. " " ..
      "--syntax-highlighting=idiomatic" .. " " ..
      "-H %s -o %%outputfile%%" .. " " ..
      "--pdf-engine=lualatex" .. " " ..
      "-V documentclass=ltjsarticle" .. " " ..
      "-V indent=true" .. " " ..
      "-V fontsize=12pt" .. " " ..
      "-V mainfont='Noto Serif'" .. " " ..
      "-V sansfont='Noto Sans'" .. " " ..
      "-V mainfontfallback='Noto Color Emoji:mode=harf'" .. " " ..
      "-V geometry:margin=1.5cm",
      listings_setup),
    mdtopdfviewerlaunch = launcher .. " %outputfile%",
    mdtopdfviewerrefresh = "none",
    mdtopdfbufferasstdin = true,
    delay = 500,
  }

  vim.keymap.set("n", "<leader>lv", function()
    require("knap").toggle_autopreviewing()
  end, { buffer = true, desc = "KNAP toggle auto-preview" })

  vim.keymap.set("n", "<leader>ll", function()
    require("knap").process_once()
  end, { buffer = true, desc = "KNAP onetime execution" })

  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { 'memo.md' },
    callback = function()
      if not (vim.b.knap_autopreviewing) then
        require("knap").toggle_autopreviewing()
      end
    end
  })
end

local function config()
  vim.api.nvim_create_autocmd({ 'BufEnter', 'Filetype' }, {
    pattern = { 'markdown', 'pandoc' },
    callback = function()
      enable_knap()
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
