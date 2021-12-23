{ pkgs, ... }:

''
  #> Syntax: bash

  SSID=$(${pkgs.networkmanager}/bin/nmcli -t -f name connection show --active)
  STATUS=$(${pkgs.networkmanager}/bin/nmcli device status | grep -m1 "wlan0" | awk '{print $3}')

  if 
          [ $STATUS = "connected" ];
  then 
    echo "$SSID"
  else 
    echo "Disconnected"
  fi
''
