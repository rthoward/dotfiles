#!/bin/sh
xrandr --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal --output VIRTUAL1 --off --output DP1 --off --output VGA1 --mode 1920x1200 --pos 0x0 --rotate normal
xrandr --output HDMI1 --primary
