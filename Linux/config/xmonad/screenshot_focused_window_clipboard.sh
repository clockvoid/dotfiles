#!/bin/sh

maim -i $(xdotool getwindowfocus) | convert - \( +clone -background black -shadow 60x30+0+10 \) +swap -background none -layers merge +repage /tmp/Screenshot_tmp.png
xclip -selection clipboard -t image/png < /tmp/Screenshot_tmp.png
