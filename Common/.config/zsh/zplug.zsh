# zplug settings
export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

# Load theme file
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
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

