[ ! -f $HOME/.config/fzf/fzf.zsh ] && return
source $HOME/.config/fzf/fzf.zsh
source <(fzf --zsh)

PREVCMD="
if [ -d {} ]; then
  if ! type tree > /dev/null; then
    ls --color -a {}
  else
    tree -C {} | head -200
  fi
else
  if ! type bat >/dev/null; then
    cat {}
  else
    bat --color=always --style=numbers,plain,changes,snip --line-range :100 {}
  fi
fi
"
export BAT_THEME="ansi"

export FZF_DEFAULT_OPTS="
--ansi
--reverse
--border
--height=-1
--wrap
--tmux='95%,90%'
--bind='ctrl-e:preview-down'
--bind='ctrl-y:preview-up'
--bind='ctrl-b:preview-page-up'
--bind='ctrl-f:preview-page-down'
--bind='ctrl-d:preview-half-page-down'
--bind='ctrl-u:preview-half-page-up'
--bind='?:toggle-preview'
--preview='${PREVCMD}'
--preview-window='right,50%,border-left,wrap,<70(bottom,50%,border-top)'
"

export FZF_CTRL_R_OPTS="
$FZF_DEFAULT_OPTS
--preview-window='default,right,50%,border-left,wrap,:hidden,<70(bottom,50%,border-top,hidden)'
"

# forgit overrides height, tmux and preview-window from FZF_DEFAULT_OPTS
# https://github.com/wfxr/forgit/blob/26.11.0/bin/git-forgit#L20-L33
export FORGIT_FZF_DEFAULT_OPTS="
--height=-1
--tmux='95%,90%'
--preview-window='default,right,50%,border-left,wrap,<70(bottom,50%,border-top)'
"

export FORGIT_ATTRIBUTES_FZF_OPTS="
--preview-window='default,right,70%,border-left,wrap,<82(bottom,50%,border-top)'
"

export FORGIT_IGNORE_FZF_OPTS="
--preview-window='default,right,70%,border-left,wrap,<82(bottom,50%,border-top)'
"

