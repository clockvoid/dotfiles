#!/bin/bash

pcnote=$(xinput list --id-only 'AT Translated Set 2 keyboard')

if [ $? -eq 0 ]; then
    setxkbmap -device $pcnote -layout us -option "ctrl:nocaps"
fi

apple=$(xinput list --id-only 'Apple Inc. Apple Internal Keyboard / Trackpad')

if [ $? -eq 0 ]; then
    setxkbmap -device $apple -layout jp -option "ctrl:nocaps"
fi

realforce=$(xinput list --id-only 'Topre REALFORCE 87 US')

if [ $? -eq 0 ]; then
    setxkbmap -device $realforce -layout us -option "ctrl:nocaps"
fi

