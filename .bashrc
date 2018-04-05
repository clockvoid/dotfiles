#
# ~/.bashrc
#

# settings for path
export PATH=$PATH:/home/clock/.gem/ruby/2.4.0/bin

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

# added by travis gem
[ -f /home/clock/.travis/travis.sh ] && source /home/clock/.travis/travis.sh
