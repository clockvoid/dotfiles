#!/bin/sh

# This shell script to install these dotfiles to your environment.
# There are possibilities to break your environment because this script is under beta.
# If your environment breaks, you have to delete dotfiles and something by hand. Sorry!

mode=""
home_dir=~/
config=""

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

print_help ()
{
cat << EOF
Usage: sh install.sh [OPTION]...
Install dotfiles to your environment.

With no OPTION, it will install all of the config to ~/

  -c, --config [CONFIGURATION_NAME]  specify installing dotfiles
  -d, --directory [DIRECTORY]        specify directory install to
  -h, --help                         print this help and exit

Dotfiles installing script by clockvoid
for information about configuration, read <https://github.com/clockvoid/dotfiles/blob/master/README.md>
EOF
}

for i in $@
do
    if [[ $mode = "directory" ]]; then
        mode=""
        home_dir=$i
    fi
    if [ $i = "-d" -o $i = "--directory" ]; then
        mode="directory"
        continue
    fi
    if [[ $mode = "config" ]]; then
        mode=""
        config=$i
    fi
    if [ $i = "-c" -o $i = "--config" ]; then
        mode="config"
        continue
    fi
    if [ $1 = "-h" -o $i = "--help" ]; then
        print_help
        exit 0
    fi
done

#home_dir=$(echo $home_dir | sed -e 's/\/$//g')
echo Install to $home_dir/..
if [ ! -d $home_dir/.config ]; then
    mkdir $home_dir/.config
fi

if [[ $config = "" ]]; then
    echo Installing all...
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
    echo Installing $config...
    if [ $config = "vim" ]; then
        vim
    elif [ $config = "neovim" ]; then
        neovim
    elif [ $config = "zsh" ]; then
        zsh
    elif [ $config = "tmux" ]; then
        tmux
    elif [ $config = "xresources" ]; then
        xresources
    elif [ $config = "xmonad" ]; then
        xmonad
    fi
fi

echo Install done!
