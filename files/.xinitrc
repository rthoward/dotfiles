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

mopidy &
xset m 1 1
compton -b &
~/.scripts/bg.sh
docky &
~/.scripts/dzen2/my_dzen.sh
exec openbox
