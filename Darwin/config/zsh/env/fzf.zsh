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
        export FZF_DEFAULT_OPTS='--preview "
            if [ -d {} ]; then
                tree -C {} | head -200
            else
                bat --color=always --style=header,grid --line-range :100 {}
            fi
        " --height 40% --border --bind ctrl-b:preview-down,ctrl-f:preview-up'
    fi

    export FZF_DEFAULT_COMMAND='find \( \
        -type d \( \
            -name .git \
        \) -prune \) -o -type f \
        ! \( \
            -name .DS_Store \
        \) -printf "%P\n"'
    export FZF_CTRL_T_COMMAND='find \( \
        -type d \( \
            -name .git \
        \) -prune \) -o \( ! -path ./. -type d \) -o \
        ! \( \
            -name .DS_Store \
        \) -printf "%P\n"'

    # Use fd (https://github.com/sharkdp/fd) instead of the default find
    # command for listing path candidates.
    # - The first argument to the function ($1) is the base path to start traversal
    # - See the source code (completion.{bash,zsh}) for the details.
    _fzf_compgen_path() {
        find "$1" \( \
            -type d \( \
                -name .git \
            \) -prune \) -o -type f \
            ! \( \
                -name .DS_Store \
        \) -printf "%P\n"
    }
    
    # Use fd to generate the list for directory completion
    _fzf_compgen_dir() {
        find "$1" \( \
            -type d \( \
                -name .git \
            \) -prune \
        \) -o \( ! -path . -type d \) -printf "%P\n"
    }
    
    # (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
    # - The first argument to the function is the name of the command.
    # - You should make sure to pass the rest of the arguments to fzf.
    _fzf_comprun() {
      local command=$1
      shift
    
      case "$command" in
        export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
        ssh)          fzf "$@" --preview 'dig {}' ;;
        *)            fzf "$@" ;;
      esac
    }

    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

    # Key bindings
    # ------------
    source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
fi

