#!/bin/sh

# Resolve copy backend: pbcopy (OSX), reattach-to-user-namespace (OSX), xclip/xsel (Linux), or network service
# get data either form stdin or from file

func_pbcopy() {
  printf "$buf" | pbcopy
}

func_mac_pbcopy() {
  printf "$buf" | reattach-to-user-namespace pbcopy
}

func_xsel() {
  printf "$buf" | xsel -i --clipboard
}

func_xclip() {
  printf "$buf" | xclip -i -f -selection primary | xclip -i -selection clipboard
}

func_ssh() {
  printf "$buf" | nc -w 1 localhost 9988
}

buf=$(cat "$@")
copy_backend=""
if type pbcopy > /dev/null 2>&1; then
    func_pbcopy
elif type reattach-to-user-namespace > /dev/null 2>&1; then
    func_mac_pbcopy
elif [ -n "${DISPLAY-}" ] && type xsel > /dev/null 2>&1; then
    func_xsel
elif [ -n "${DISPLAY-}" ] && type xclip > /dev/null 2>&1; then
    func_xclip
fi
if [ "$(ss -n -4 state listening "( sport = 9988 )" | tail -n +2 | wc -l)" -eq 1 ]; then
    func_ssh
fi

exit;

