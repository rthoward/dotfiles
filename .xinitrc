#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

WM="bspwm"

xrdb ~/.Xresources
xset +fp ~/.fonts
~/.scripts/screen_res.sh
mopidy &
nitrogen --restore &
compton -b

if [ $WM = "bspwm" ]; then
   sxhkd -f 100 &
   xsetroot -cursor_name left_ptr
   exec bspwm
elif [ $WM = "openbox" ]; then
   ~/.scripts/panel
   exec openbox-session
fi
