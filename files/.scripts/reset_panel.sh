#!/bin/bash

gen_panel_pid=$(ps aux | grep 'gen_panel.sh' | grep -v 'vim\|grep' | awk {'print $2'};)
kill $gen_panel_pid
killall dzen2
~/.scripts/panel &
