#!/bin/sh

sink=`pactl get-default-sink`
pactl set-sink-volume $sink -3%
