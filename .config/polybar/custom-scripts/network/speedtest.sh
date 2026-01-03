#!/bin/bash

polybar-msg action "#testing-network-speed.hook.1"

RESULT=$(speedtest-cli --simple --single --bytes --no-upload | paste -sd' ' - | awk '{print "Ping: "int($2)"ms Download: "$5""$6}')

notify-send "Speedtest" "$RESULT"

polybar-msg action "#testing-network-speed.hook.0"
