let g:python3_host_prog=expand('~/.anyenv/envs/pyenv/versions/3.11.4/bin/python')
let g:node_host_prog=expand('~/.anyenv/envs/nodenv/versions/19.3.0/bin/neovim-node-host')
let g:loaded_ruby_provider=0
let g:loaded_perl_provider=0

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
