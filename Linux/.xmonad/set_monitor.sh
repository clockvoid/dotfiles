#!/bin/sh

# the script will not work if xrandr is not available
if [ -z "$(which xrandr)" ]; then
    exit 1
fi

INTERNAL="eDP1"
IS_CONNECT_EXTERNAL="false"
EXTERNAL_PRIMARY="HDMI1"

xrandr --output "$INTERNAL" --primary --auto

old_IFS="${IFS}"
IFS=$'\n'
for out in `xrandr | grep connected | cut -d ' ' -f 1-2`; do
    name=`echo $out | cut -d ' ' -f 1`
    state=`echo $out | cut -d ' ' -f 2`
    case "$state" in
        "connected"*)
            if [ "$name" = "${EXTERNAL_PRIMARY}" ]; then
                IS_CONNECT_EXTERNAL="true"
                xrandr --output "$EXTERNAL_PRIMARY" --primary --auto
            elif [ "$name" != "${INTERNAL}" ]; then
                xrandr --output "$name" --auto --right-of "${EXTERNAL_PRIMARY}"
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

if [ "$IS_CONNECT_EXTERNAL" = "false" ]; then
    if [ `pidof redshift | wc -w` = 0 ]; then
        redshift -P -m randr -t 5700:3600 -b 1.0:1.0 -l 35.465:139.622 &
    fi
else
    for pid in `pidof redshift`; do
        redshift -xP
        kill $pid
    done
    lid_state=`cat /proc/acpi/button/lid/LID0/state | sed 's/ \+/ /g' | cut -d' ' -f2`
    if [ $lid_state = "closed" ]; then
        xrandr --output "$INTERNAL" --off
    else
        xrandr --output "$INTERNAL" --auto --pos 320x1440
    fi
fi
