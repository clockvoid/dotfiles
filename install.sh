#!/bin/sh

# This shell script to install these dotfiles to your environment.
# There are possibilities to break your environment because this script is under beta.
# If your environment breaks, you have to delete dotfiles and something by hand. Sorry!

powerline ()
{
    cp -r ./.config/powerline ~/.config/
}

install_dein()
{
    if [ ! -e ~/.cache ]; then
        mkdir ~/.cache
    fi
    if [ ! -e ~/.cache/dein ]; then
        mkdir ~/.cache/dein
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
        sh ./installer.sh ~/.cache/deina/
    fi
}

vim ()
{
    cp -r ./.*vim* ~/
    install_dein
}

tmux ()
{
    if [ ! -e ~/.local ]; then
        mkdir ~/.local/bin
    fi
    if [ ! -e ~/.local/bin ]; then
        mkdir ~/.local/bin
    fi
    cp -r ./shell ~/.local/bin
    cp ./.tmux.conf ~/
    if [ ! -e ~/.tmux ];  then
        mkdir ~/.tmux
    fi
    if [ ! -e ~/.tmux/plugins ]; then
        mkdir ~/.tmux/plugins
    fi
    if [! -e ~/.tmux/plugins/tmp ]; then
        mkdir ~/.tmux/plugins/tpm
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
    powerline
}

gtk ()
{
    cp ./.gtkrc-2.0 ~/
    cp ./.config/gtk-* ~/.config/
}

lightdm ()
{
    gtk
    cp ./lightdm ~/
}

xmonad ()
{
    cp -r ./.xmo* ~/
    cp ./.xinitrc ~/
    cp ./.xprofile ~/
}

xresources ()
{
    cp -r ./.Xresources* ~/
}

zsh ()
{
    cp ./.zshrc ~/
    powerline
}

feh ()
{
    cp ./.fehbg ~/
}

git ()
{
    cp -r ./.git_template ~/
}

neovim ()
{
    cp -r ./.config/nvim/ ~/.config/
    install_dein
}

if [ "$#" -eq 0 ]; then
    powerline
    vim
    tmux
    lightdm
    xmonad
    xresources
    zsh
    feh
    git
    neovim
else if [ "$1" -eq "vim" ]; then
    vim
else if [ "$1" -eq "neovim" ]; then
    neovim
else if [ "$1" -eq "zsh" ]; then
    zsh
fi
