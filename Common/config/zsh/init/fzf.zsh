[ ! -f $HOME/.config/fzf/fzf.zsh ] && return
source $HOME/.config/fzf/fzf.zsh
source <(fzf --zsh)

PREVCMD="
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
    bat --theme=ansi --color=always --style=header,grid --line-range :100 {}
  fi
fi
"

export FZF_DEFAULT_OPTS="--preview '${PREVCMD}' \
  --border \
  --bind ctrl-e:preview-down,ctrl-y:preview-up,ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up \
  --height=-1 \
  --reverse \
  --tmux 90%,70% \
  "

export FZF_CTRL_R_OPTS='--reverse --preview-window=":hidden"'

export FORGIT_FZF_DEFAULT_OPTS="--height=-1 --tmux 90%,70%"
