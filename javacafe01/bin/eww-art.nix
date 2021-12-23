{ pkgs, ... }:
''
  #> Syntax: bash

  # Script to download art and return path

  tmp_dir="$XDG_CACHE_HOME/eww/"

  if [ -z "$XDG_CACHE_HOME" ]; then
      tmp_dir="$HOME/.cache/eww/"
  fi

  tmp_cover_path="''${tmp_dir}cover.png"

  if [ ! -d "$tmp_dir" ]; then
      mkdir -p $tmp_dir
  fi

  ${pkgs.curl}/bin/curl -s $1 --output $tmp_cover_path

  echo "$tmp_cover_path"

''
