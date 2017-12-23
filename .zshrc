# Created by newuser for 5.3.1

#
# ~/.zshrc copyed by ~/.bashrc
#

# Set the zsh root directoy
export ZSH_ROOT=$HOME/.zsh
# auto start tmux
export ZSH_TMUX_AUTOSTART=true

# settings for path
export PATH=$PATH:/home/clock/.gem/ruby/2.4.0/bin:/home/clock/.local/bin

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable using colors
autoload -Uz colors
colors

# TMUX
#if which tmux >/dev/null 2>&1; then
#    # if no session is started, start a new session
#    test -z ${TMUX} && tmux
#
#    # when quitting tmux, try to attach
#    while test -z ${TMUX}; do
#        tmux attach || break
#    done
#fi
#source $ZSH_ROOT/functions/tmux.zsh

# powerline
source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

# make keybindings be like vim
bindkey -v

alias ls='ls --color=auto'
# alias urxvt='urxvt -e zsh -c "tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$HOSTNAME"'
# PROMPT="[%n@%m %~]$ "
alias vim='nvim'

# for completion
autoload -Uz compinit
compinit
# enable move directory by directory name
setopt auto_cd
# enable output last cd directory
setopt auto_pushd
# enable complete correct command
setopt correct
# enable compact list
setopt list_packed
# disable beep
setopt nolist_beep

# disable distinction to small and capital letter
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# complete command after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
							/usr/sbin /usr/bin /bin

# completion for ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# for vim
#export TERM=xterm-256color

# for yaourt pkgbuild editor
export VISUAL="nvim"

# for rbenv initalization
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

# for default editor setting
export EDITOR="nvim"

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# for history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history    # share command history data

# added by travis gem
[ -f /home/clock/.travis/travis.sh ] && source /home/clock/.travis/travis.sh

# for colored man page
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
