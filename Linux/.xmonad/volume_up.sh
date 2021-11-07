#!/bin/sh

sink=`pactl get-default-sink`
pactl set-sink-volume $sink +5%
sleep 0.05
pactl play-sample audio-volume-change $sink
