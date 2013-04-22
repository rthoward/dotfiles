#!/bin/sh

# settings
ICONPATH="$HOME/.scripts/dzen2/icons"
COLOR_ICON="#6e9bcf"
CRIT_COLOR="#ff2c4a"
DZEN_FG="#aaaaaa"
DZEN_BG="#111111"
RESOLUTIONW=1920
RESOLUTIONH=1200
HEIGHT=15
WIDTH=1920
X=$(($RESOLUTIONW-$WIDTH))
Y=0
BAR_FG="#aaaaaa"
BAR_BG="#111111"
BAR_H=10
BAR_W=60
FONT="-artwiz-anorexia-medium-r-normal--11-110-75-75-p-90-iso8859-1"
SLEEP=1
VUP="mpc volume +1"
VDOWN="mpc volume -1"
EVENT="button3=exit;button4=exec:$VUP;button5=exec:$VDOWN"
DZEN="dzen2 -x $X -y $Y -w $WIDTH -h $HEIGHT -fn $FONT -ta 'right' -bg $DZEN_BG -fg $DZEN_FG -e "button3=exit;button4=exec:$VUP;button5=exec:$VDOWN""

# loop
while :; do
sleep ${SLEEP}

# functions
Vol ()
{
  ONF=$(amixer get Master | awk '/Front\ Left:/ {print $7}' | tr -d '[]')
  VOL=$(amixer get Master | awk '/Front\ Left:/ {print $5}' | tr -d '[]%')
    if [[ ${ONF} == 'off' ]] ; then
       echo -n "^fg($CRIT_COLOR)^i($ICONPATH/spkr_01.xbm)^fg()" $(echo "0"  | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -ss 1 -sw 2 -nonl)
    else
       echo -n "^fg($COLOR_ICON)^i($ICONPATH/spkr_01.xbm)^fg()" ${VOL} $(echo $VOL | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -ss 1 -sw 2 -nonl)
    fi
    return
}

Mem ()
{
  MEM=$(free -m | grep '-' | awk '{print $3}')
  echo -n "^fg($COLOR_ICON)^i($ICONPATH/mem.xbm)^fg() ${MEM} M"
  return
}

Date ()
{
  TIME=$(date +%R)
    echo -n "^fg($COLOR_ICON)^i($ICONPATH/clock.xbm)^fg() ${TIME}"
  return
}

Mpd ()
{
  OUTPUT=$(mpc -f %artist%,%title%,%album%,%position%,%date%,)
  ARTIST=$(echo $OUTPUT | cut -d',' -f1)
  TITLE=$(echo $OUTPUT | cut -d',' -f2)
  ALBUM=$(echo $OUTPUT | cut -d',' -f3)
  POSITION=$(echo $OUTPUT | cut -d',' -f4)
  YEAR=$(echo $OUTPUT | cut -d',' -f5)  
  PLAYLIST_SIZE=$(mpc playlist | wc -l)
  echo -n "^fg($COLOR_ICON)^i($ICONPATH/music.xbm)^fg(#000000)"
  Between
  echo -n "^fg(#45ADA8)${ARTIST}"
  Between
  echo -n "^fg(#E5FCC2)${TITLE}"
  Between
  echo -n "^fg(#547980)${ALBUM}"
  Between
  echo -n "^fg(#F9CDAD)${POSITION} / $PLAYLIST_SIZE"
  Between
  echo -n "${YEAR}"
}

Between ()
{
    echo -n " ^fg(#7298a9)^r(2x2)^fg() "
  return
}

Print () {      
  Mpd
  Between       
  Vol
  Between
  Date
  
  return
}

echo "$(Print)"
done | $DZEN &