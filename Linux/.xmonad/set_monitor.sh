#!/bin/sh

# the script will not work if xrandr is not available
if [ -z "$(which xrandr)" ]; then
    exit 1
fi

INTERNAL="eDP1"
IS_CONNECT_EXTERNAL="false"

old_IFS="${IFS}"
IFS=$'\n'
for out in `xrandr | grep connected | cut -d ' ' -f 1-2`; do
    name=`echo $out | cut -d ' ' -f 1`
    state=`echo $out | cut -d ' ' -f 2`
    echo "name is $name, INTERNAL is ${INTERNAL}"
    if [ "$state" = "connected" ]; then
        if [ ! "$name" = ${INTERNAL} ]; then
            IS_CONNECT_EXTERNAL="true"
        fi
    fi
done
IFS="${old_IFS}"

redshift -xP

for pid in `pidof redshift`; do
    kill $pid
done

if [ "$IS_CONNECT_EXTERNAL" = "false" ]; then
    redshift -P -m randr -t 5700:3600 -b 1.0:1.0 -l 35.465:139.622 &
fi
