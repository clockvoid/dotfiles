vim.g.python3_host_prog = vim.fn.expand('~/.anyenv/envs/pyenv/versions/3.11.4/bin/python')
vim.g.node_host_porg = vim.fn.expand('~/.anyenv/envs/nodenv/versions/19.3.0/bin/neovim-node-host')
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.g.clipboard = {
  name = 'xclip',
  copy = {
    ["+"] = 'xclip -selection clipboard',
    ["*"] = 'xclip -selection clipboard',
  },
  paste = {
    ["+"] = 'xclip -selection clipboard -o',
    ["*"] = 'xclip -selection clipboard -o',
  },
  cache_enabled = 1,
}
