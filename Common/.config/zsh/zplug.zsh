# zplug settings
export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

# Load theme file
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug 'wfxr/forgit'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

