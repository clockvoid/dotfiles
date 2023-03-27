#!/bin/sh

# the script will not work if xrandr is not available
if [ -z "$(which xrandr)" ]; then
    exit 1
fi

INTERNAL="eDP-1"
IS_CONNECT_EXTERNAL_PRIMARY="false"
IS_CONNECT_EXTERNAL_SECONDARY="false"
EXTERNAL_PRIMARY="DP-3-8"
EXTERNAL_SECONDARY="DP-3-1-8"

old_IFS="${IFS}"
IFS=$'\n'
for out in `xrandr | grep connected | cut -d ' ' -f 1-2`; do
    name=`echo $out | cut -d ' ' -f 1`
    state=`echo $out | cut -d ' ' -f 2`
    case "$state" in
        "connected"*)
            if [ "$name" = "${EXTERNAL_PRIMARY}" ]; then
                IS_CONNECT_EXTERNAL_PRIMARY="true"
            elif [ "$name" = "${EXTERNAL_SECONDARY}" ]; then
                IS_CONNECT_EXTERNAL_SECONDARY="true"
            elif [ "$name" = "$INTERNAL" ]; then
                # do nothing
                echo ""
            else
                xrandr --output "$name" --off
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

# output setting for external monitor
if [ "$IS_CONNECT_EXTERNAL_SECONDARY" = "true" ]; then
    if [ "$IS_CONNECT_EXTERNAL_PRIMARY" = "true" ]; then
            xrandr --output "$EXTERNAL_PRIMARY" --primary --auto
            xrandr --output "$EXTERNAL_SECONDARY" --auto --right-of "$EXTERNAL_PRIMARY"
    else
            xrandr --output "$EXTERNAL_SECONDARY" --primary --auto
    fi
elif [ "$IS_CONNECT_EXTERNAL_PRIMARY" = "true" ]; then
    xrandr --output "$EXTERNAL_PRIMARY" --primary --auto
fi

# output setting for internal monitor
if [ `cat /proc/acpi/button/lid/LID/state | cut -d ' ' -f 7` == "closed" ]; then
    xrandr --output "$INTERNAL" --off
else
    if [ "$IS_CONNECT_EXTERNAL_PRIMARY" = "true" ]; then
        xrandr --output "$INTERNAL" --primary --auto --below "$EXTERNAL_PRIMARY"
    elif [ "$IS_CONNECT_EXTERNAL_SECONDARY" = "true" ]; then
        xrandr --output "$INTERNAL" --primary --auto --below "$EXTERNAL_SECONDARY"
    else
        xrandr --output "$INTERNAL" --primary --auto
    fi
fi

feh --no-fehbg --bg-fill '/etc/lightdm/wallpaper.png'
