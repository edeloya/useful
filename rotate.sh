#!/bin/sh
# invert_screen copyright 20170516 alexx MIT Licence ver 1.0
orientation=$(xrandr -q|grep -v dis|grep connected|awk '{print $4}')
display=$(xrandr -q|grep -v dis|grep connected|awk '{print $1}')
if [ "$orientation" != "(normal" ]; then
   xrandr --output $display --rotate normal
   xinput set-prop "Elan Touchscreen" --type=float  "Coordinate Transformation Matrix" 0 0 0 0 0 0 0 0 0
else
   xrandr --output $display --rotate right
   xinput set-prop "Elan Touchscreen" --type=float  "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
fi
