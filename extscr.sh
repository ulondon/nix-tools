#!/usr/bin/bash

# TODO: add option to duplicate screen

screens=$(xrandr | grep connected | grep -v dis | awk '{print $1}')
#mainScr=$(echo $screens | grep -i dp | head -1 | awk '{print $1}')
#extScr=$(echo $screens | grep -i hdmi | head -1 | awk '{print $1}')
mainScr=$(echo $screens | awk '{print $1}')
extScr=$(echo $screens | awk '{print $2}')

if [ "$1" == "-d" ]; then
  xrandr --output $extScr --off
  exit 0
fi

xrandr --output $mainScr --primary --auto --output $extScr --right-of $mainScr --auto
