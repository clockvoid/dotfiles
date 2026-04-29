#!/bin/sh

add_resolution_for_xreal.sh

IS_GLASS_CONNECTED="false"
INTERNAL="eDP-1"
EXTERNAL_GLASS="DP-1"

old_IFS="${IFS}"
IFS=$'\n'
for out in `xrandr | grep connected | cut -d ' ' -f 1-2`; do
    name=`echo $out | cut -d ' ' -f 1`
    state=`echo $out | cut -d ' ' -f 2`
    case "$state" in
        "connected"*)
            if [ "$name" = "${EXTERNAL_GLASS}" ]; then
              IS_GLASS_CONNECTED="true"
            else
                # do nothing
                echo ""
            fi
            ;;
        "disconnected"*)
                xrandr --output "$name" --off
            ;;
        *)
            ;;
    esac
done
IFS="${old_IFS}"

if [ "$IS_GLASS_CONNECTED" = "true" ]; then
  xrandr --output "$EXTERNAL_GLASS" --primary --mode "3840x1080_60.00"
  xrandr --output "$INTERNAL" --off
fi

feh --no-fehbg --bg-fill '/etc/lightdm/wallpaper.png'
xmonad --restart

