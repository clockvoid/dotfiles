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
        mkdir -p $home_dir/.anyenv/plugins
        git clone https://github.com/znz/anyenv-update.git $home_dir/.anyenv/anyenv-update
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
    if [ ! -d $home_dir/.anyenv/envs/jenv ]; then
        anyenv install jenv
        eval "$(anyenv init -)"
    fi
}

install_sdkman() {
  if [ ! -d $home_dir/.sdkman ]; then
    curl -s "https://get.sdkman.io" | bash
    git restore .
    source ~/.zshrc
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
    ln -sf $(pwd)/$environment/shell/* $home_dir/.local/bin/
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
        ln -sf $(pwd)/Linux/config/systemd/user/* $home_dir/.config/systemd/user/
    fi
    echo SystemdMods: Done
}

fontconfig ()
{
    if [ "$environment" = "Linux" ]; then
        ln -sf $(pwd)/Linux/config/fontconfig $home_dir/.config/
    else
        echo This system do not need this configuration.
    fi
    echo Fontconfig: Done
}

ideavim ()
{
    ln -sf $(pwd)/Common/ideavimrc $home_dir/.ideavimrc
    echo IdeaVim: Done
}

tmux ()
{
    install_local_bin
    install_systemd_mods
    if [ ! -d $home_dir/.tmux ]; then
        mkdir $home_dir/.tmux
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
    ln -sf $(pwd)/$environment/config/tmux/env $(pwd)/Common/config/tmux/
    ln -sf $(pwd)/Common/config/tmux $home_dir/.config/
    if [ $environment == "Darwin" ]; then
        ln -sf $(pwd)/Darwin/Library/LaunchAgents/* $home_dir/Library/LaunchAgents/
        launchctl load ~/Library/LaunchAgents/local.pbcopy.9988.plist
        brew install reattach-to-user-namespace coreutils
    fi
    echo Tmux: Done
}

gtk ()
{
    if [ $environment == "Linux" ]; then
        ln -sf $(pwd)/Linux/gtkrc-2.0 $home_dir/.gtkrc-2.0
        ln -sf $(pwd)/Linux/config/gtk-* $home_dir/.config/
        command -v dconf >/dev/null && dconf write /org/gnome/desktop/interface/color-scheme \'prefer-dark\'
    else
        echo This system do not need this configuration.
    fi
    echo GTK: Done
}

lightdm ()
{
    if [ $environment == "Linux" ]; then
        gtk
        sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.tmp
        sudo cp /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.tmp
        sudo cp $(pwd)/Linux/lightdm/* /etc/lightdm
    else
        echo This system do not need this configuration.
    fi

    bold=$(tput bold)
}

picom ()
{
    if [ $environment == "Linux" ]; then
        ln -sf $(pwd)/Linux/config/picom $home_dir/.config/
    else
        echo This system do not need this configuration.
    fi
}

install_ghcup ()
{
    if [ ! -d $home_dir/.ghcup ]; then
        curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
        source ~/.ghcup/env
    fi

    if [ ! -d $home_dir/.stack ]; then
        mkdir $home_dir/.stack
    fi
    ln -sf $(pwd)/Common/stack/config.yaml $home_dir/.stack/

    echo ghcup: Done
}

xmonad ()
{
    if [ $environment == "Linux" ]; then
        ln -sf $(pwd)/Linux/config/xmonad $home_dir/.config
        ln -sf $(pwd)/Linux/xinitrc $home_dir/.xinitrc
        ln -sf $(pwd)/Linux/xprofile $home_dir/.xprofile

        install_local_bin
        install_ghcup

        type stack || {
            echo 'Please install stack via ghcup!'
            exit 1
        }

        type git || {
            echo 'Please install git or update your path to include the git executable!'
            exit 1
        }

        git submodule update --init --recursive

        current_dir="$(pwd)"

        cd $(pwd)/Linux/config/xmonad
        stack install
        cd $current_dir

        if [ ! -d /usr/share/xsessions ]; then
            sudo mkdir /usr/share/xsessions
        fi
        sudo cp $(pwd)/Linux/config/xmonad/xmonad.desktop /usr/share/xsessions
        echo Exec=$HOME/.local/bin/xmonad | sudo tee -a /usr/share/xsessions/xmonad.desktop
        sudo cp $(pwd)/Linux/libinput/30-touchpad.conf /etc/X11/xorg.conf.d/
    else
        echo This system do not need this configuration.
    fi
    echo Xmonad: Done
}

xremap ()
{
    if [ "$environment" = "Linux" ]; then
        ln -sf $(pwd)/Linux/config/xremap $home_dir/.config
        echo 'uinput' | sudo tee /etc/modules-load.d/uinput.conf
        echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules
        sudo gpasswd -a `whoami` input
    else
        echo This system do not need this config.
    fi
    echo xremap: Done
}

xresources ()
{
    if [ $environment = "Linux" ]; then
        ln -sf $(pwd)/Linux/Xresources $home_dir/.Xresources

        if [ ! -L $home_dir/.Xresources.d ]; then
            ln -s $(pwd)/Linux/Xresources.d $home_dir/.Xresources.d
        fi
    else
        echo This system do not need this configuration.
    fi
    echo Xresources: Done
}

alacritty ()
{
    ln -sf $(pwd)/$environment/config/alacritty/env.toml $(pwd)/Common/config/alacritty
    ln -sf $(pwd)/Common/config/alacritty/ $home_dir/.config/
    echo Alacritty: Done
}

zsh ()
{
    if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
        type git || {
            echo 'Please install git or update your path to include the git executable!'
            exit 1
        }
        command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
        command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
    fi
    ln -sf $(pwd)/$environment/config/zsh/env.zsh $(pwd)/Common/config/zsh/
    ln -sf $(pwd)/$environment/config/zsh/init/env $(pwd)/Common/config/zsh/init/
    ln -sf $(pwd)/Common/config/zsh $home_dir/.config/
    ln -sf $(pwd)/Common/zshrc $home_dir/.zshrc

    if [ $environment == "Darwin" ]; then
        ln -sf $(pwd)/Darwin/zprofile $home_dir/.zprofile
    fi
    echo Zsh: Done
}

git_template ()
{
    if [ ! -L $home_dir/.git_template ]; then
        ln -s $(pwd)/Common/git_template $home_dir/.git_template
    fi
    echo Git: Done
}

neovim ()
{
    install_anyenv
    python_version="3.11.4"
    node_version="19.3.0"
    if ! echo "$(pyenv versions)" | grep -q "$python_version"; then
        type make || {
            echo 'Please install make or update your path to include the make executable!'
                    echo 'Also, you should install gcc and zlib1g-dev on Ubuntu 18.04.'
                    exit 1
                }
                pyenv install $python_version
                pyenv local $python_version
                python -m pip install --user --upgrade pynvim
                pyenv local --unset
    fi
    if ! echo "$(nodenv versions)" | grep -q "$node_version"; then
        nodenv install $node_version
        nodenv global $node_version
        nodenv rehash
        nodenv exec npm install -g neovim
    fi
    ln -sf $(pwd)/Common/config/nvim/ $home_dir/.config/
    ln -sf $(pwd)/${environment}/config/nvim/lua/env $home_dir/.config/nvim/lua/
    echo Neovim: Done
}

feh () {
    if [ $environment == "Linux" ]; then
        ln -sf $(pwd)/Linux/config/feh/ $home_dir/.config/
        echo Feh: Done
    else
        echo Feh settings is not needed to your environment.
    fi
}

aerospace() {
  if [ $environment == "Darwin" ]; then
    if [ ! -d $home_dir/.config/aerospace ]; then
      ln -sf $(pwd)/Darwin/config/aerospace $home_dir/.config/
    fi
  fi
}

mac_utils() {
    if [ $environment == "Darwin" ]; then
        type brew || {
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        }
        brew update
        brew install bat coreutils findutils fd fzf git neovim tmux zsh
        brew install dozer alacritty hyperswitch karabiner-elements
        brew install --cask nikitabobko/tap/aerospace
    fi
}

redshift() {
    if [ $environment == "Linux" ]; then
        ln -sf $(pwd)/Linux/config/redshift/ $home_dir/.config/
        echo redshift: Done
    fi
}

print_help ()
{
cat << EOS
Usage: sh install.sh [OPTION]...
Install dotfiles to your environment.

With no OPTION, it will install all of the configs to ~/

  -c, --config [CONFIGURATION_NAME]  specify installing dotfiles
                                     can be: anyenv
                                             local-bin
                                             systemd-mods
                                             fontconfig
                                             ideavim
                                             tmux
                                             gtk
                                             lightdm
                                             haskell
                                             xmonad
                                             xremap
                                             xresources
                                             alacritty
                                             zsh
                                             git_template
                                             neovim
                                             feh
                                             aerospace
                                             mac-utils
                                             redshift
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
    fontconfig
    ideavim
    tmux
    lightdm
    picom
    xmonad
    xremap
    xresources
    alacritty
    zsh
    git_template
    neovim
    feh
    aerospace
    mac_utils
    redshift
elif [ $config = "haskell" ]; then
    install_ghcup
elif [ $config = "sdkman" ]; then
    install_sdkman
elif [ $config = "ideavim" ]; then
    ideavim
elif [ $config = "neovim" ]; then
    neovim
elif [ $config = "zsh" ]; then
    zsh
elif [ $config = "tmux" ]; then
    tmux
elif [ $config = "gtk" ]; then
    gtk
elif [ $config = "xresources" ]; then
    xresources
elif [ $config = "xmonad" ]; then
    xmonad
elif [ $config = "xremap" ]; then
    xremap
elif [ $config = "lightdm" ]; then
    lightdm
elif [ $config = "fontconfig" ]; then
    fontconfig
elif [ $config = "alacritty" ]; then
    alacritty
elif [ $config = "anyenv" ]; then
    install_anyenv
elif [ $config = "git_template" ]; then
    git_template
elif [ $config = "mac-utils" ]; then
    mac_utils
elif [ $config = "local-bin" ]; then
    install_local_bin
elif [ $config = "systemd-mods" ]; then
    install_systemd_mods
elif [ $config = "feh" ]; then
    feh
elif [ $config = "redshift" ]; then
    redshift
elif [ $config = "picom" ]; then
    picom
elif [ $config = "aerospace" ]; then
    aerospace
else
    echo Config set $config not found.
fi

echo Install done!
