export ANYENV_ROOT=$HOME/.anyenv
export PYENV_ROOT=$ANYENV_ROOT/pyenv

export PATH=$ANYENV_ROOT/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

eval "$(anyenv init -)"

if type "direnv" > /dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

