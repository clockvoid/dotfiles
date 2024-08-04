export LC_ALL="en_US.UTF-8"
bindkey -v

export VISUAL="nvim"
export EDITOR="nvim"

alias ls='ls --color=auto'
alias rm='rm -v'

# enable output last cd directory
setopt auto_pushd
# enable compact list
setopt list_packed
# disable beep
setopt nolist_beep

# disable distinction to small and capital letter
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# complete command after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /bin

# completion for ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# historical backward/forward search with linehead string binded to ^P/^N
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Key stroke settings
KEYTIMEOUT=1

autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
autoload history-search-end

export ANYENV_ROOT=$HOME/.anyenv
export PATH=$ANYENV_ROOT/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

command -v anyenv >/dev/null && eval "$(anyenv init -)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
[ -f $HOME/.travis/travis.sh ] && . $HOME/.travis/travis.sh # added by travis gem
if [[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  source "$HOME/.sdkman/bin/sdkman-init.sh" # sdkman
fi

[[ -f ~/.dart-cli-completion/zsh-config.zsh ]] && . ~/.dart-cli-completion/zsh-config.zsh || true
