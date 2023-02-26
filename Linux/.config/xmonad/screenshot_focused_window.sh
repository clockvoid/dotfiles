#!/bin/sh

maim -i $(xdotool getwindowfocus) | convert - \( +clone -background black -shadow 60x30+0+10 \) +swap -background none -layers merge +repage $1/Screenshot_at_$(date +%Y-%m-%d-%H-%M-%S).png
