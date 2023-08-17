#!/bin/sh

sink=`pactl get-default-source`
pactl set-source-mute $sink toggle
