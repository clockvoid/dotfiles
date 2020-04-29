#!/bin/sh

# This shell script to install these dotfiles to your environment.
# There are possibilities to break your environment because this script is under beta.
# If your environment breaks, you have to delete dotfiles and something by hand. Sorry!

mode="normal"
home_dir=~/
config="all"
environment=$(uname)

install_anyenv()
{
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

install_local_bin()
{
    if [ ! -d $home_dir/.local ]; then
        mkdir $home_dir/.local
    fi
    if [ ! -d $home_dir/.local/bin ]; then
        mkdir $home_dir/.local/bin
    fi
    ln -s $(pwd)/$environment/shell/* $home_dir/.local/bin/
}

install_systemd_mods()
{
    if [ $environment == "Linux" ]; then
        if [ ! -d $home_dir/.config/systemd ]; then
            mkdir $home_dir/.config/systemd
        fi
        if [ ! -d $home_dir/.config/systemd/user ]; then
            mkdir $home_dir/.config/systemd/user
        fi
        ln -s $(pwd)/Linux/.config/systemd/user/* $home_dir/.config/systemd/user/
    fi
    echo SystemdMods: Done
}

fontconfig ()
{
    if [ $environment == "Linux" ]; then
        ln -s $(pwd)/Linux/.config/fontconfig $home_dir/.config/
    else
        echo This system do not need this configuration.
    fi
    echo Fontconfig: Done
}

ideavim ()
{
    ln -s $(pwd)/Common/.ideavimrc $home_dir/
    echo IdeaVim: Done
}

tmux ()
{
    install_local_bin
    install_systemd_mods
    if [ ! -d $home_dir/.tmux ]; then
        mkdir $home_dir/.tmux
    fi
    if [ ! -d $home_dir/.tmux/tmux-powerline ]; then
        type git || {
          echo 'Please install git or update your path to include the git executable!'
          exit 1
        }
        git clone https://github.com/erikw/tmux-powerline $home_dir/.tmux/tmux-powerline
    fi
    if [ ! -d $home_dir/.tmux/plugins ]; then
        mkdir $home_dir/.tmux/plugins
    fi
    if [ ! -d $home_dir/.tmux/plugins/tpm ]; then
        type git || {
          echo 'Please install git or update your path to include the git executable!'
          exit 1
        }
        git clone https://github.com/tmux-plugins/tpm $home_dir/.tmux/plugins/tpm
    fi
    ln -s $(pwd)/Common/tmux-poweline-themes/* $home_dir/.tmux/tmux-powerline/themes/
    ln -s $(pwd)/Common/.tmux-powerlinerc $home_dir/
    ln -s $(pwd)/Common/.tmux.conf $home_dir/
    ln -s $(pwd)/$environment/.config/tmux/env $(pwd)/Common/.config/tmux/
    ln -s $(pwd)/Common/.config/tmux $home_dir/.config/
    if [ $environment == "Darwin" ]; then
        brew install reattach-to-user-namespace coreutils
    fi
    echo Tmux: Done
}

gtk ()
{
    if [ $environment == "Linux" ]; then
        ln -s $(pwd)/Linux/.gtkrc-2.0 $home_dir/
        ln -s $(pwd)/Linux/.config/gtk-* $home_dir/.config/
    else
        echo This system do not need this configuration.
    fi
    echo GTK: Done
}

lightdm ()
{
    if [ $environment == "Linux" ]; then
        gtk
        ln -s $(pwd)/Linux/lightdm $home_dir/
    else
        echo This system do not need this configuration.
    fi
    echo LightDM: Done: Please copy files in $home_dir/lightdm/ to /etc/lightdm/!
}

xmonad ()
{
    if [ $environment == "Linux" ]; then
        ln -s $(pwd)/Linux/.xmo* $home_dir/
        ln -s $(pwd)/Linux/.xinitrc $home_dir/
        ln -s $(pwd)/Linux/.xprofile $home_dir/
    else
        echo This system do not need this configuration.
    fi
    echo Xmonad: Done
}

xresources ()
{
    if [ $environment == "Linux" ]; then
        ln -s $(pwd)/Linux/.Xresources* $home_dir/
    else
        echo This system do not need this configuration.
    fi
    echo Xresources: Done
}

alacritty ()
{
    ln -s $(pwd)/Common/.config/alacritty/ $home_dir/.config/
    echo Alacritty: Done
}

zsh ()
{
    if [ ! -d $home_dir/.zplug ]; then
        type git || {
            echo 'Please install git or update your path to include the git executable!'
            exit 1
        }
        git clone https://github.com/zplug/zplug $home_dir/.zplug
    fi
    ln -s $(pwd)/$environment/.config/zsh/env $(pwd)/Common/.config/zsh/
    ln -s $(pwd)/Common/.config/zsh $home_dir/.config/
    ln -s $(pwd)/Common/.zshrc $home_dir/
    echo Zsh: Done
}

feh ()
{
    if [ $environment == "Linux" ]; then
        ln -s $(pwd)/Linux/.fehbg $home_dir/
    else
        echo This system do not need this configuration.
    fi
    echo Feh: Done
}

git_template ()
{
    ln -s $(pwd)/Common/.git_template $home_dir/
    echo Git: Done
}

neovim ()
{
    install_anyenv
    install_dein
    if ! echo "$(pyenv versions)" | grep -q "3.7.6"; then
        type make || {
            echo 'Please install make or update your path to include the make executable!'
            echo 'Also, you should install gcc and zlib1g-dev on Ubuntu 18.04.'
            exit 1
        }
        pyenv install 3.8.1
        pyenv local 3.8.1
        pip install pynvim
        pyenv local --unset
    fi
    if ! echo "$(pyenv versions)" | grep -q "2.7.17"; then
        type make || {
            echo 'Please install make or update your path to include the make executable!'
            echo 'Also, you should install gcc and zlib1g-dev and libssl-dev on Ubuntu 18.04.'
            exit 1
        }
        pyenv install 2.7.17
        pyenv local 2.7.17
        pip install pynvim
        pyenv local --unset
    fi
    if ! echo "$(rbenv versions)" | grep -q "2.4.0"; then
        type make || {
            echo 'Please install make or update your path to include the make executable!'
            exit 1
        }
        rbenv install 2.4.0
        rbenv local 2.4.0
        gem install neovim
        rbenv local --unset
    fi
    if ! echo "$(nodenv versions)" | grep -q "13.5.0"; then
        nodenv install 13.5.0
        nodenv local 13.5.0
        nodenv exec npm install -g neovim
        nodenv local --unset
    fi
    ln -s $(pwd)/Common/.config/nvim/ $home_dir/.config/
    echo Neovim: Done
}

terminator ()
{
    ln -s $(pwd)/Common/.config/terminator/ $home_dir/.config/
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
    if [ $mode = "normal" ]; then
        if expr $i : "^-.*$" > /dev/null; then
            mode=$(check_mode $i)
            continue
        else
            print_error $i
        fi
    elif [ $mode = "directory" ]; then
        mode="normal"
        home_dir=$i
    elif [ $mode = "config" ]; then
        mode="normal"
        config=$i
    else
        print_error $i
    fi
done

if [ $mode = "help" ]; then
    print_help
fi

#home_dir=$(echo $home_dir | sed -e 's/\/$//g')
echo Install to $home_dir/..
if [ ! -d $home_dir/.config ]; then
    mkdir $home_dir/.config
fi

echo Installing $config...
if [ $config = "all" ]; then
    tmux
    ideavim
    lightdm
    xmonad
    xresources
    zsh
    feh
    git_template
    neovim
    alacritty
elif [ $config = "ideavim" ]; then
    ideavim
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
elif [ $config = "fontconfig" ]; then
    fontconfig
elif [ $config = "alacritty" ]; then
    alacritty
elif [ $config = "anyenv" ]; then
    install_anyenv
else
    echo Config set $config not found.
fi

echo Install done!
