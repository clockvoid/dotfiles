bindkey -v

alias ls='ls --color=auto'
alias rm='rm -v'

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
zstyle ':completion:*:sudo:*' command-path\
    /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /bin

# completion for ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# historical backward/forward search with linehead string binded to ^P/^N
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Key stroke settings
KEYTIMEOUT=1
