# Created by newuser for 5.3.1

#
# ~/.zshrc copyed by ~/.bashrc
#

# locale
export LC_ALL="en_US.UTF-8"

# If not in the tmux session, don't do anything
[[ $TMUX == "" ]] && return

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set the zsh root directoy
export ZSH_ROOT=$HOME/.zsh
source $HOME/.config/zsh/zinit.zsh

for file in $HOME/.config/zsh/env/*.zsh; do
    source "$file"
done

for file in $HOME/.config/zsh/init/*.zsh; do
    source "$file"
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

