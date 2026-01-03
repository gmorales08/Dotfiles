#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo "%{F#b2b2b2} B "
else
  if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then
    echo "%{F#ffffff} B "
  fi
  echo "%{F#ffd700}.B."
fi
