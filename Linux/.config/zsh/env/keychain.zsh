if ! type "keychain" > /dev/null; then
    echo 'Please isntall keychain using package manager!'
else
    if ! { [ -n "$TMUX" ]; } then
        eval $(keychain --eval --agents ssh -Q --quiet ~/.ssh/id_*)
    fi
fi
