#!/usr/bin/env bash

shut="Shutdown"
reboot="Reboot"
lock="Lock"
susp="Suspend"
exyeet="Logout"

options="$shut\n$reboot\n$lock\n$susp\n$exyeet"

thechosenone="$(echo -e "$options" | rofi -lines 5 -dmenu -p "Power" -theme power/gruvbox.rasi)"

case $thechosenone in
    $shut)
        systemctl poweroff;;
    $reboot)
        systemctl reboot;;
    $lock)
        ~/.bin/lock;;
    $susp)
        systemctl suspend;;
    $exyeet)
        bspc quit;;
esac
