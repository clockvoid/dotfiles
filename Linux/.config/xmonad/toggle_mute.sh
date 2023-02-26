#!/bin/sh

sink=`pactl get-default-sink`
pactl set-sink-mute $sink toggle
