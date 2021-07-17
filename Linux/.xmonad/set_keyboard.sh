#!/bin/bash

letsnote=$(xinput list --id-only 'AT Translated Set 2 keyboard')

if [ $? -eq 0 ]; then
    setxkbmap -device $letsnote -layout jp -option "ctrl:nocaps"
fi

realforce=$(xinput list --id-only 'Topre REALFORCE 87 US')

if [ $? -eq 0 ]; then
    setxkbmap -device $realforce -layout us -option "ctrl:nocaps"
fi

