#!/bin/sh

sink=`pactl get-default-sink`
pactl set-sink-mute $sink toggle
sleep 0.05
pactl play-sample audio-volume-change $sink
