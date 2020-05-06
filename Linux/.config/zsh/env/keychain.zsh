if ! type "keychain" > /dev/null; then
    echo 'Please isntall keychain using package manager!'
else
    eval $(keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa)
fi
