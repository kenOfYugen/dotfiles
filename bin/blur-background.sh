#! /bin/sh

bspc subscribe | while read -r line; do
    node_num=$(bspc query --nodes --desktop | wc -l)
    if [ "$node_num" != "0" ]; then
	feh --bg-fill ~/Pictures/wallpapers/bg_blur.png
    else
	feh --bg-fill ~/Pictures/wallpapers/bg.png
    fi
done;
