# Setup fzf
# ---------

if ! type fzf > /dev/null; then

    echo "Please install fzf!"
else

    if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
      export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
    fi

    if ! type bat > /dev/null; then
        echo "Please install bat."
    else
        export FZF_DEFAULT_OPTS='--reverse --preview "bat  --color=always --style=header,grid --line-range :100 {}" --height 40% --border'
    fi

    if ! type rg > /dev/null; then
        echo "Plase install ripgrep."
    else
        export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "\!.git/**" --glob "\!Library/**"'
    fi

    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

    # Key bindings
    # ------------
    source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi

