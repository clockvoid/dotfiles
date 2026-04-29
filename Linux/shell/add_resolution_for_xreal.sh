#!/bin/sh

xrandr --newmode "2560x1080_60.00"  230.00  2560 2720 2992 3424  1080 1083 1093 1120 -hsync +vsync
xrandr --newmode "3840x1080_60.00"  346.00  3840 4088 4496 5152  1080 1083 1093 1120 -hsync +vsync
xrandr --addmode DP-1 2560x1080_60.00
xrandr --addmode DP-1 3840x1080_60.00

