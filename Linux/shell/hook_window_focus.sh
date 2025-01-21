#!/usr/bin/bash
xset s off
xset s noblank

while read -r line 
do
        WINDOW_ID="$(echo  $line | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')"
        CLASS=$(xprop -id $WINDOW_ID | awk '/WM_CLASS/{$1=$2="";print}' | cut -d'"' -f2)
        if [ $CLASS == "Navigator" ] || [ $CLASS == "discord" ]; then
          echo "dpms off"
          xset -dpms
        else
          echo "dpms on"
          xset dpms 600 900 0
        fi
done < <(xprop -spy -root _NET_ACTIVE_WINDOW)
