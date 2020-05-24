#! /bin/sh

bspc subscribe | while read -r line; do
    node_num=$(bspc query --nodes --desktop | wc -l)
    if [ "$node_num" == "1" ]; then
        bspc config border_width 0
        bspc config window_gap   0
    else
        bspc config border_width 3
        bspc config window_gap   5
    fi
done;
