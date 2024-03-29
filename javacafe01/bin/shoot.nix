{ pkgs, ... }:

''
  #> Syntax: bash

  # My script for screenshots, im bad at scripting pls help to make smaller

  img="shot_$(date '+%m%d%H%M%S').png"
  file="$HOME/Pictures/screenshots/$img"

  case $1 in
      "sel")
          slop=$(slop -c '0.61,0.9,0.75,1' -p 18 -f "%g") || exit 1
          read -r G < <(echo $slop)
          import -window root -crop $G $file
          ;;

      "selnp")
          slop=$(slop -c '0.61,0.9,0.75,1' -f "%g") || exit 1
          read -r G < <(echo $slop)
          import -window root -crop $G $file
          ;;

      "selnpshad")
          slop=$(slop -c '0.61,0.9,0.75,1' -f "%g") || exit 1
          read -r G < <(echo $slop)
          import -window root -crop $G $file
          convert $file \( +clone -background black -shadow 75x10+0+0 \) +swap -bordercolor none -border 10 -background none -layers merge +repage $file
          ;;

      *)
          import -window root $file
          ;;
  esac


  ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -i  $file
  ${pkgs.libnotify}/bin/notify-send -i $file "Screenshot saved" -a "Shoot"
''
