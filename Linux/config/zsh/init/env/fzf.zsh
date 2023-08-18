if [ -f $HOME/.fzf.zsh ]; then
    source $HOME/.fzf.zsh

    export FZF_DEFAULT_OPTS='--preview "
    if [ -d {} ]; then
        ls --color -a {}
    else
        cat {}
    fi
    " --border --bind ctrl-b:preview-down,ctrl-f:preview-up'

    export FZF_DEFAULT_COMMAND='find \( \
        -type d \( \
        -name .git \
        \) -prune \) -o -type f -printf "%P\n"'

    export FZF_CTRL_T_COMMAND='find \( \
        -type d \( \
        -name .git \
        \) -prune \) -o \( ! -path ./. -type d \) -o -printf "%P\n"'

    # Use fd (https://github.com/sharkdp/fd) instead of the default find
    # command for listing path candidates.
    # - The first argument to the function ($1) is the base path to start traversal
    # - See the source code (completion.{bash,zsh}) for the details.
    _fzf_compgen_path() {
        find "$1" \( -type d \( \
            -name .git \
            \) -prune \) -o -type f -printf "%P\n"
        }

    # Use fd to generate the list for directory completion
    _fzf_compgen_dir() {
        find "$1" \( \
            -type d \( \
            -name .git \
            \) -prune \
            \) -o \( ! -path . -type d \) -printf "%P\n"
        }
fi
