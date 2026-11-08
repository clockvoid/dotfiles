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
    bat --color=always --style=header,grid --line-range :100 {}
  fi
fi
"
export BAT_THEME="ansi"

export FZF_DEFAULT_OPTS="--preview '${PREVCMD}' \
  --border \
  --bind ctrl-e:preview-down \
  --bind ctrl-y:preview-up \
  --bind ctrl-b:preview-page-up \
  --bind ctrl-f:preview-page-down \
  --bind ctrl-d:preview-half-page-down \
  --bind ctrl-u:preview-half-page-up \
  --bind ?:toggle-preview \
  --preview-window 'right,border-left,wrap,<55(bottom,border-top)' \
  --height=-1 \
  --reverse \
  --tmux 95%,90% \
"

export FZF_CTRL_R_OPTS="$FZF_DEFAULT_OPTS
  --preview-window=':hidden,<55(bottom,border-top,hidden)'
"

export FORGIT_FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"

