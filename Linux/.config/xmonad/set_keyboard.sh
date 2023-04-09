#!/bin/bash

pcnote=$(xinput list --id-only 'AT Translated Set 2 keyboard')
keymap=$(localectl status | grep Keymap | cut -d ' ' -f 7)

if [ $? -eq 0 ]; then
    if [ $keymap = jp106 ]; then
        setxkbmap -device $pcnote -layout jp -option "ctrl:nocaps"
    else
        setxkbmap -device $pcnote -layout us -option "ctrl:nocaps"
    fi
fi

apple=$(xinput list --id-only 'Apple Inc. Apple Internal Keyboard / Trackpad')

if [ $? -eq 0 ]; then
    setxkbmap -device $apple -layout jp -option "ctrl:nocaps"
fi

realforce=$(xinput list --id-only 'Topre REALFORCE 87 US')

if [ $? -eq 0 ]; then
    setxkbmap -device $realforce -layout us -option "ctrl:nocaps"
fi

