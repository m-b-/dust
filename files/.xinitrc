#!/bin/sh

# load decent keymap
setxkbmap fr bepo
xmodmap ~/.Xmodmap

# ensure sufficient path
PATH=$PATH:$HOME/plan9/bin/:$HOME/bin

# launch the plumber
9 plumber
9p write plumb/rules < .plumbrules

# launch urxvtd if needed
( ps aux | grep urxvtd | grep -v grep ) || urxvtd -q -f -o

#$WM &
dwm &
p=$!

# in case wheel-click has been disabled..
# xinput set-prop "AlpsPS/2 ALPS GlidePoint" "Evdev Middle Button Emulation" 1

sleep 3
dwm_status&

while true; do
	randbg $HOME/imgs/
	sleep 1800 # 30min
done &

wait $p
