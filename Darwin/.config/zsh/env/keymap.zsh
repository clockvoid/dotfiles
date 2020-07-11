# make keybindings be like vim
bindkey -v

# aliases
alias ls='ls --color=auto'
alias ovim='/usr/bin/vim'
alias vim='nvim'
alias vimf='nvim -c FZF'
alias v='nvim'
alias vf='nvim -c FZF'
alias g='git'
alias t='tmux'
alias y='yaourt'
alias c='clear'
alias e='exit'
alias f='fzf'
alias rm='rm -v'

# for completion
autoload -Uz compinit
compinit
# enable move directory by directory name
setopt auto_cd
# enable output last cd directory
setopt auto_pushd
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

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Key stroke settings
KEYTIMEOUT=1

