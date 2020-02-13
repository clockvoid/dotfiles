#!/bin/sh

# This shell script to install these dotfiles to your environment.
# There are possibilities to break your environment because this script is under beta.
# If your environment breaks, you have to delete dotfiles and something by hand. Sorry!

mode="normal"
home_dir=~/
config="all"

install_anyenv() {
    if [ ! -d $home_dir/.anyenv ]; then
        type git || {
            echo 'Please install git or update your path to include the git executable!'
            exit 1
        }
        git clone https://github.com/anyenv/anyenv $home_dir/.anyenv
    fi
    export PATH="$home_dir/.anyenv/bin:$PATH"
    eval "$(anyenv init -)" 
    if [ ! -d $home_dir/.config/anyenv/anyenv-install ]; then
        anyenv install --init
    fi
}

fontconfig ()
{
    ln -s $(pwd)/.config/fontconfig $home_dir/.config/
    echo Fontconfig: Done
}

install_dein()
{
    if [ ! -d $home_dir/.cache ]; then
        mkdir $home_dir/.cache
    fi
    if [ ! -d $home_dir/.cache/dein ]; then
        mkdir $home_dir/.cache/dein
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_installer.sh
        sh $(pwd)/dein_installer.sh $home_dir/.cache/dein/ >/dev/null
    fi
}

vim ()
{
    ln -s $(pwd)/.*vim* $home_dir/
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
    ln -s $(pwd)/shell/* $home_dir/.local/bin/
    if [ ! -d $home_dir/.config/systemd ]; then
        mkdir $home_dir/.config/systemd
    fi
    if [ ! -d $home_dir/.config/systemd/user ]; then
        mkdir $home_dir/.config/systemd/user
    fi
    ln -s $(pwd)/.config/systemd/user/* $home_dir/.config/systemd/user/
    ln -s $(pwd)/.tmux-powerlinerc $home_dir/
    ln -s $(pwd)/.tmux.conf $home_dir/
    if [ ! -d $home_dir/.tmux ]; then
        mkdir $home_dir/.tmux
    fi
    if [ ! -d $home_dir/.tmux/tmux-powerline ]; then
        mkdir $home_dir$(pwd)/tmux/tmux-powerline
        type git || {
          echo 'Please install git or update your path to include the git executable!'
          exit 1
        }
        git clone https://github.com/erikw/tmux-powerline $home_dir/.tmux/tmux-powerline
    fi
    ln -s $(pwd)/tmux-poweline-themes/* $home_dir/.tmux/tmux-powerline/themes/
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
    echo Tmux: Done
}

gtk ()
{
    ln -s $(pwd)/.gtkrc-2.0 $home_dir/
    ln -s $(pwd)/.config/gtk-* $home_dir/.config/
    echo GTK: Done
}

lightdm ()
{
    gtk
    ln -s $(pwd)/lightdm $home_dir/
    echo LightDM: Done: Please copy files in $home_dir/lightdm/ to /etc/lightdm/!
}

xmonad ()
{
    ln -s $(pwd)/.xmo* $home_dir/
    ln -s $(pwd)/.xinitrc $home_dir/
    ln -s $(pwd)/.xprofile $home_dir/
    echo Xmonad: Done
}

xresources ()
{
    ln -s $(pwd)/.Xresources* $home_dir/
    echo Xresources: Done
}

alacritty ()
{
    ln -s $(pwd)/.config/alacritty/ $home_dir/.config/
    echo Alacritty: Done
}

zsh ()
{
    ln -s $(pwd)/.zshrc $home_dir/
    echo Zsh: Done
}

feh ()
{
    ln -s $(pwd)/.fehbg $home_dir/
    echo Feh: Done
}

git_template ()
{
    ln -s $(pwd)/.git_template $home_dir/
    echo Git: Done
}

neovim ()
{
    if [ ! -d $home_dir/.anyenv/envs/rbenv ]; then
        anyenv install rbenv
        eval "$(anyenv init -)" 
    fi
    if [ ! -d $home_dir/.anyenv/envs/pyenv ]; then
        anyenv install pyenv
        eval "$(anyenv init -)" 
    fi
    if [ ! -d $home_dir/.anyenv/envs/nodenv ]; then
        anyenv install nodenv
        eval "$(anyenv init -)" 
    fi
    if ! echo "$(pyenv versions)" | grep -q "3.6.5"; then
        type make || {
            echo 'Please install make or update your path to include the make executable!'
            exit 1
        }
        pyenv install 3.6.5
    fi
    ln -s $(pwd)/.config/nvim/ $home_dir/.config/
    install_dein
    echo Neovim: Done
}

terminator ()
{
    ln -s $(pwd)/.config/terminator/ $home_dir/.config/
    echo Terminator: Done
}

print_help ()
{
cat << EOS
Usage: sh install.sh [OPTION]...
Install dotfiles to your environment.

With no OPTION, it will install all of the configs to ~/

  -c, --config [CONFIGURATION_NAME]  specify installing dotfiles
  -d, --directory [DIRECTORY]        specify directory install to
  -h, --help                         print this help and exit

Dotfiles installing script by clockvoid
For more information about these dotfiles, read <https://github.com/clockvoid/dotfiles/blob/master/README.md>
EOS
exit 0
}

print_error ()
{
    echo Invalid option: $1
    echo See sh install.sh --help
    exit 0
}

check_mode ()
{
    if [ $1 = "-d" -o $1 = "--directory" ]; then
        echo "directory"
    elif [ $1 = "-c" -o $1 = "--config" ]; then
        echo "config"
    elif [ $1 = "-h" -o $1 = "--help" ]; then
        echo "help"
    else
        echo "error"
    fi
}

for i in $@
do
    if [[ $mode = "normal" ]]; then
        if expr $i : "^-.*$" > /dev/null; then
            mode=$(check_mode $i)
            continue
        else
            print_error $i
        fi
    elif [[ $mode = "directory" ]]; then
        mode="normal"
        home_dir=$i
    elif [[ $mode = "config" ]]; then
        mode="normal"
        config=$i
    else
        print_error $i
    fi
done

if [[ $mode = "help" ]]; then
    print_help
fi

#home_dir=$(echo $home_dir | sed -e 's/\/$//g')
echo Install to $home_dir/..
if [ ! -d $home_dir/.config ]; then
    mkdir $home_dir/.config
fi

echo Installing $config...
if [[ $config = "all" ]]; then
    install_anyenv
    tmux
    vim
    lightdm
    xmonad
    xresources
    zsh
    feh
    git_template
    neovim
    alacritty
elif [ $config = "vim" ]; then
    install_anyenv
    vim
elif [ $config = "neovim" ]; then
    install_anyenv
    neovim
elif [ $config = "zsh" ]; then
    install_anyenv
    zsh
elif [ $config = "tmux" ]; then
    install_anyenv
    tmux
elif [ $config = "xresources" ]; then
    install_anyenv
    xresources
elif [ $config = "xmonad" ]; then
    install_anyenv
    xmonad
elif [ $config = "fontconfig" ]; then
    install_anyenv
    fontconfig
elif [ $config = "alacritty" ]; then
    install_anyenv
    alacritty
elif [ $config = "anyenv" ]; then
    install_anyenv
else
    echo Config set $config not found.
fi

echo Install done!
