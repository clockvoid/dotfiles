# Setup fzf
# ---------
[ ! -f $HOME/.config/fzf/fzf.zsh ] && return
source $HOME/.config/fzf/fzf.zsh

export FZF_DEFAULT_OPTS='--preview "
if [ -d {} ]; then
    if ! type tree > /dev/null; then
        echo \"To see perfect preview, install tree\" && ls --color -a {}
    else
        tree -C {} | head -200
    fi
else
    if ! type bat >/dev/null; then
        echo \"To see perfect preview, install bat\" && cat {}
    else
        bat --theme=Nord --color=always --style=header,grid --line-range :100 {}
    fi
fi
" --height 40% --border --bind ctrl-b:preview-down,ctrl-f:preview-up'

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

# fd - cd to selected directory
fdr() {
    local dir prevcmd
    if ! type tree > /dev/null; then
        prevcmd='echo "To see perfect preview, install tree" && ls --color -a {}'
    else
        prevcmd='tree -C {} | head -200'
    fi
    dir=$(fd --hidden --follow --exclude ".git" --exclude "Library" --max-depth 5 | fzf +m --reverse --preview "$prevcmd") && cd "$dir"
}
