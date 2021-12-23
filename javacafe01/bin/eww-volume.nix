{ pkgs, ... }:

''
  #> Syntax: bash

  STATUS=$(${pkgs.pamixer}/bin/pamixer --get-mute)

  if 
    [ $STATUS = true ];
  then 
    echo       
  else
    echo 
  fi
''
