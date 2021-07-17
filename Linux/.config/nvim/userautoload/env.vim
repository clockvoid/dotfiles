let g:python3_host_prog=expand('~/.anyenv/envs/pyenv/versions/3.9.5/bin/python')
let g:python_host_prog=expand('~/.anyenv/envs/pyenv/versions/2.7.17/bin/python')
let g:ruby_host_prog=expand('~/.anyenv/envs/rbenv/versions/2.7.0/bin/neovim-ruby-host')
let g:node_host_prog=expand('~/.anyenv/envs/nodenv/versions/15.6.0/bin/neovim-node-host')

let g:clipboard = {
  \   'name': 'xclip',
  \   'copy': {
  \      '+': 'xclip -selection clipboard',
  \      '*': 'xclip -selection clipboard',
  \    },
  \   'paste': {
  \      '+': 'xclip -selection clipboard -o',
  \      '*': 'xclip -selection clipboard -o',
  \   },
  \   'cache_enabled': 1,
  \ }
