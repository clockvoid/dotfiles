[ ! -f $HOME/.config/fzf/fzf.zsh ] && return

source $HOME/.config/fzf/fzf.zsh

export FZF_DEFAULT_OPTS='--preview \
"
if [ -d {} ]; then
    if ! type tree > /dev/null; then
        ls --color -a {}
    else
        tree -C {} | head -200
    fi
else
    if ! type bat >/dev/null; then
        echo \"To see perfect preview, install bat\" && cat {}
    else
        bat --color=always --style=header,grid --line-range :100 {}
    fi
fi
"
--border --bind ctrl-b:preview-down,ctrl-f:preview-up'

export FZF_DEFAULT_COMMAND='find \( \
    -type d \( \
    -name .git \
    \) -prune \) -o -type f -printf "%P\n"'

export FZF_CTRL_T_COMMAND='find \( \
    -type d \( \
    -name .git \
    \) -prune \) -o \( ! -path ./. -type d \) -o -printf "%P\n"'

_fzf_compgen_path() {
    find "$1" \( -type d \( \
        -name .git \
    \) -prune \) -o -type f -printf "%P\n"
}

_fzf_compgen_dir() {
    find "$1" \( -type d \( \
        -name .git \
    \) -prune \) -o \( ! -path . -type d \) -printf "%P\n"
}

# fd - cd to selected directory
fdr() {
    local dir prevcmd
    if ! type tree > /dev/null; then
        prevcmd='echo To see perfect preview, install tree && ls {}'
    else
        prevcmd='tree -C {} | head -200'
    fi
    dir=$(_fzf_compgen_dir . | fzf +m --reverse --preview "$prevcmd") && cd "$dir"
}
