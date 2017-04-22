#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# for vim
export TERM=xterm-256color

# for yaourt pkgbuild editor
export VISUAL="vim"

# for rbenv initalization
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

# for default editor setting
export EDITOR="vim"
