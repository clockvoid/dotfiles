[ ! -f $HOME/.config/fzf/fzf.zsh ] && return
source $HOME/.config/fzf/fzf.zsh

PREVCMD="
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
export FZF_DEFAULT_OPTS="--preview '${PREVCMD}' \
  --border \
  --bind ctrl-e:preview-down,ctrl-y:preview-up,ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up \
  --height=-1 \
  --reverse \
  "

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

export FZF_CTRL_R_OPTS='--reverse --preview-window=":hidden"'

export FORGIT_FZF_DEFAULT_OPTS="--height=-1"

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
fd() {
    local dir prevcmd
    if ! type tree > /dev/null; then
        prevcmd='echo To see perfect preview, install tree && ls {}'
    else
        prevcmd='tree -C {} | head -200'
    fi
    dir=$(_fzf_compgen_dir . | fzf +m --preview "$prevcmd") && cd "$dir"
}

