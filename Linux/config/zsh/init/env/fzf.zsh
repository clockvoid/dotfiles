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
  -printf "%P\n" \
  '

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

