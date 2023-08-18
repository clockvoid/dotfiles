export LC_ALL="en_US.UTF-8"

autoload -Uz compinit
compinit
autoload -Uz promptinit
promptinit

export ANYENV_ROOT=$HOME/.anyenv
export PATH=$ANYENV_ROOT/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

command -v anyenv >/dev/null && eval "$(anyenv init -)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
[ -f $HOME/.travis/travis.sh ] && . $HOME/.travis/travis.sh # added by travis gem

source $HOME/.config/zsh/path.zsh
