#!/bin/sh

maim -i $(xdotool getwindowfocus) $1/Screenshot_at_$(date +%Y-%m-%d-%H-%M-%S).png
