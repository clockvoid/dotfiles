local function hook_post_source()
  vim.g.fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-x'] = 'split',
    ['ctrl-v'] = 'vsplit'
  }

  if vim.fn.exists('$TMUX') == 1 then
    vim.g.fzf_layout = { tmux = '95%,90%' }
  else
    vim.g.fzf_layout = { window = { width = 0.95, height = 0.9, relative = true } }
  end

  vim.g.fzf_colors = {
    fg      = { 'fg', 'Normal' },
    bg      = { 'bg', 'Normal' },
    hl      = { 'fg', 'Comment' },
    ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
    ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
    ['hl+'] = { 'fg', 'Statement' },
    info    = { 'fg', 'PreProc' },
    prompt  = { 'fg', 'Conditional' },
    pointer = { 'fg', 'Exception' },
    marker  = { 'fg', 'Keyword' },
    spinner = { 'fg', 'Label' },
    header  = { 'fg', 'Comment' }
  }

  vim.g.fzf_history_dir = '~/.local/share/fzf-history'

  vim.env.BAT_THEME = 'ansi'
  -- See also: Common/config/zsh/init/fzf.zsh
  vim.g.fzf_options = {
    "--ansi",
    "--reverse",
    "--border",
    "--height", "-1",
    "--wrap",
    "--tmux", "95%,90%",
    "--bind", "ctrl-e:preview-down",
    "--bind", "ctrl-y:preview-up",
    "--bind", "ctrl-b:preview-page-up",
    "--bind", "ctrl-f:preview-page-down",
    "--bind", "ctrl-d:preview-half-page-down",
    "--bind", "ctrl-u:preview-half-page-up",
    "--bind", "?:toggle-preview",
  }
  vim.g.fzf_preview_window = { 'right,50%,border-left,wrap,<70(bottom,50%,border-top)' }
  vim.g.fzf_tags_options = "--preview=''"
end

return {
  {
    'junegunn/fzf',
    build = 'bash ./install --all --xdg --no-update-rc --no-bash --no-fish'
  },
  {
    'junegunn/fzf.vim',
    config = hook_post_source(),
    dependencies = { 'junegunn/fzf' }
  },
}
