#!/bin/sh

# This shell script to install these dotfiles to your environment.
# There are possibilities to break your environment because this script is under beta.
# If your environment breaks, you have to delete dotfiles and something by hand. Sorry!

if [ $# -gt 0 ]; then
    home_dir=$1
    if [ ! -d $home_dir ]; then
        mkdir $home_dir
    fi
else
    home_dir=~/
fi

echo Install those files to $home_dir/...

if [ ! -d $home_dir/.config ]; then
    mkdir $home_dir/.config
fi

powerline ()
{
    cp -r ./.config/powerline $home_dir/.config/
    echo PowerLine: Done
}

install_dein()
{
    if [ ! -d $home_dir/.cache ]; then
        mkdir $home_dir/.cache
    fi
    if [ ! -d $home_dir/.cache/dein ]; then
        mkdir $home_dir/.cache/dein
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
        sh ./installer.sh $home_dir/.cache/dein/ >/dev/null
    fi
}

vim ()
{
    cp -r ./.*vim* $home_dir/
    install_dein
    echo Vim: Done
}

tmux ()
{
    # TODO: separate installing shell/* to function shell_tools
    if [ ! -d $home_dir/.local ]; then
        mkdir $home_dir/.local
    fi
    if [ ! -d $home_dir/.local/bin ]; then
        mkdir $home_dir/.local/bin
    fi
    cp ./shell/* $home_dir/.local/bin/
    cp ./.tmux.conf $home_dir/
    if [ ! -d $home_dir/.tmux ]; then
        mkdir $home_dir/.tmux
    fi
    if [ ! -d $home_dir/.tmux/plugins ]; then
        mkdir $home_dir/.tmux/plugins
    fi
    if [ ! -d $home_dir/.tmux/plugins/tpm ]; then
        mkdir $home_dir/.tmux/plugins/tpm
        # check git command
        type git || {
          echo 'Please install git or update your path to include the git executable!'
          exit 1
        }
        git clone https://github.com/tmux-plugins/tpm $home_dir/.tmux/plugins/tpm
    fi
    powerline
    echo Tmux: Done
}

gtk ()
{
    cp ./.gtkrc-2.0 $home_dir/
    cp -r ./.config/gtk-* $home_dir/.config/
    echo GTK: Done
}

lightdm ()
{
    gtk
    cp -r ./lightdm $home_dir/
    echo LightDM: Done: Please copy files in $home_dir/lightdm/ to /etc/lightdm/!
}

xmonad ()
{
    cp -r ./.xmo* $home_dir/
    cp ./.xinitrc $home_dir/
    cp ./.xprofile $home_dir/
    echo Xmonad: Done
}

xresources ()
{
    cp -r ./.Xresources* $home_dir/
    echo Xresources: Done
}

zsh ()
{
    cp ./.zshrc $home_dir/
    powerline
    echo Zsh: Done
}

feh ()
{
    cp ./.fehbg $home_dir/
    echo Feh: Done
}

git_template ()
{
    cp -r ./.git_template $home_dir/
    echo Git: Done
}

neovim ()
{
    cp -r ./.config/nvim/ $home_dir/.config/
    install_dein
    echo Neovim: Done
}

if [ $# -le 1 ]; then
    tmux
    vim
    lightdm
    xmonad
    xresources
    zsh
    feh
    git_template
    neovim
else
    if [ $2 = "vim" ]; then
        vim
    elif [ $2 = "neovim" ]; then
        neovim
    elif [ $2 = "zsh" ]; then
        zsh
    fi
fi

echo Install done!
