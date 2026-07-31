export FZF_DEFAULT_COMMAND='find \
  \( \
    -type d \
    \( \
      -name .git \
    \) \
    -prune \
  \) \
  -o \
  -type f \
  ! \( \
    -name .DS_Store \
  \) \
  -printf "%P\n" \
  '

export FZF_CTRL_T_COMMAND='find \
  \( \
    -type d \
    \( \
      -name .git \
    \) \
    -prune \
  \) \
  -o \
  \( \
    ! -path ./. \
    -type d \
  \) \
  -o \
  ! \( \
    -name .DS_Store \
  \) \
  -printf "%P\n" \
  '

_fzf_compgen_path() {
    find "$1" \( \
        -type d \( \
        -name .git \
        \) -prune \) -o -type f \
        ! \( \
        -name .DS_Store \
        \) -printf "%P\n"
}

_fzf_compgen_dir() {
    find "$1" \( \
        -type d \( \
        -name .git \
        \) -prune \
        \) -o \( ! -path . -type d \) -printf "%P\n"
}

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
fd() {
    local dir prevcmd
    if ! type tree > /dev/null; then
        prevcmd='echo "To see perfect preview, install tree" && ls --color -a {}'
    else
        prevcmd='tree -C {} | head -200'
    fi
    dir=$(fd --hidden --follow --exclude ".git" --exclude "Library" --max-depth 5 | fzf +m "$prevcmd") && cd "$dir"
}

