# Created by newuser for 5.3.1

#
# ~/.zshrc copyed by ~/.bashrc
#

# locale
export LC_ALL="en_US.UTF-8"

# Set the zsh root directoy
export ZSH_ROOT=$HOME/.zsh

source $HOME/.config/zsh/zplug.zsh
source $HOME/.config/zsh/path.zsh

eval "$(anyenv init -)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.config/zsh/color.zsh
source $HOME/.config/zsh/keymap.zsh
source $HOME/.config/zsh/editors.zsh
source $HOME/.config/zsh/histories.zsh
source $HOME/.config/zsh/travis.zsh
source $HOME/.config/zsh/fzf.zsh
source $HOME/.config/zsh/alacritty.zsh
source $HOME/.config/zsh/gcloud.zsh
if [ -f "$HOME/.config/zsh/brew.zsh" ]; then . $HOME/.config/zsh/brew.zsh; fi

