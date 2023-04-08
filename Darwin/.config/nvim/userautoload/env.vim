lang ja_JP.UTF-8

let g:python3_host_prog=expand('~/.anyenv/envs/pyenv/versions/3.9.5/bin/python')
let g:ruby_host_prog=expand('~/.anyenv/envs/rbenv/versions/2.7.4/bin/neovim-ruby-host')
let g:node_host_prog=expand('~/.anyenv/envs/nodenv/versions/15.6.0/bin/neovim-node-host')
let g:loaded_perl_provider = 0

if exists('$TMUX')
    set clipboard+=unnamedplus
endif
