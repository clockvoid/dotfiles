#!/bin/bash

xrandr --output "eDP-1" --primary --auto
feh --no-fehbg --bg-fill '/etc/lightdm/wallpaper.png'
xmonar --restart

