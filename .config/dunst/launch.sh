#!/usr/bin/env sh

killall -q dunst

while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done

dunst -nb $(xgetres background) -nf $(xgetres foreground) -nfr $(xgetres color0) \ 
      -lb $(xgetres background) -lf $(xgetres foreground) -lfr $(xgetres color0) \
      -cb $(xgetres background) -cf $(xgetres color1) -cfr $(xgetres color0)
