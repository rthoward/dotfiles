#!/bin/bash

workspace(){
   SPACE_NUM=$(wmctrl -d | grep '* DG' | cut -d' ' -f1);
		case "$SPACE_NUM" in
			"0")
				WORKSPACE="■ □ □ □";;
			"1")
				WORKSPACE="□ ■ □ □";;
			"2")
				WORKSPACE="□ □ ■ □";;
			"3")
				WORKSPACE="□ □ □ ■";;
		esac
	echo $WORKSPACE
}

ram(){
	echo  $(free -m | awk '/-/ {print $3}')
}

dat(){
	echo  $(date "+%H:%M  %D")
}

vol(){
   echo -n "⮞ "
	echo  $(amixer get Master | egrep -o "[0-9]+%")
}

mus(){
   if [ $(mpc | grep -q '\[paused\]') ]; then
      # paused
      echo -n "⮔ "
      echo "[ not playing ]"
   else
      # playing
	   echo -n "⮓ "
      echo $(mpc current)
   fi
}

pause(){
	echo  $(mpc | if grep -q "paused"; then echo "(paused)"; fi)
}

cpu(){
	echo  $(mpstat 2 1 | awk '$3 ~ /CPU/ { for(i=1;i<=NF;i++) { if ($i ~ /%idle/) field=i } } $3 ~ /all/ {printf"%d",100 - $field}')
}

while :; do
   echo  "^pa(4)$(workspace) ^pa(800) $(mus) ^pa(1780)$(vol) $(dat)"
sleep 0.5
done
