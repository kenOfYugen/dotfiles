#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## Github : @adi1090x
## Reddit : @adi1090x

rofi_command="rofi -theme themes/screenshot.rasi"

# Options
screen=""
area=""
window=""

# Variable passed to rofi
options="$screen\n$area\n$window"

chosen="$(echo -e "$options" | $rofi_command -p '' -dmenu -selected-row 1)"
case $chosen in
    $screen)
        sleep 2; maim -u ~/Pictures/screenshots/$(date +%s).png
        ;;
    $area)
        maim -s -u ~/Pictures/screenshots/$(date +%s).png
        ;;
    $window)
        sleep 2; maim -i -u $(xdotool getactivewindow) ~/Pictures/screenshots/$(date +%s).png
	;;
esac

