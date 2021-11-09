{}:

''
  {
      "position": "bottom", // Waybar position (top|bottom|left|right)
      "modules-left": [ "cpu", "memory", "clock", "mpd" ],
      "modules-center": ["sway/workspaces"],
      "modules-right": ["backlight", "pulseaudio",  "battery", "network", "tray"],
      // Modules configuration
       "sway/workspaces": {
         "all-outputs": true,
         "format": " {icon} ",
         "persistent_workspaces": {
                 "1": [],
                 "2": [],
                 "3": [],
                 "4": [],
                 "5": [],
               //  "6": [],
               //  "7": [],
               //  "8": [],
               //  "9": [],
               },      
         "disable-scroll": false,
           "format-icons": {
         "1": "一",
         "2": "二",
         "3": "三",
         "4": "四",
         "5": "五",
           //    "6": "六",
           //    "7": "七",
           //    "8": "八",
           //    "9": "九",
               "urgent": " ",
               "focused": " ",
               "default": " "
           } 
       },
      "sway/mode": {
          "format": " {} "
      },
      "sway/window": {
          "format": "<span style=\"italic\">{}</span>"
      },
      "mpd": {
          "format": "  {title} {stateIcon} ",
          "format-disconnected": "Disconnected",
          "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon} Stopped ",
          "unknown-tag": "N/A",
          "interval": 2,
          "consume-icons": {
              "on": " "
          },
          "random-icons": {
              "off": "<span color=\"#f53c3c\"></span> ",
              "on": " "
          },
          "repeat-icons": {
              "on": " "
          },
          "single-icons": {
              "on": "1 "
          },
          "state-icons": {
              "playing": "",
              "paused": ""
          },
          "tooltip-format": "MPD (connected)",
          "tooltip-format-disconnected": "MPD (disconnected)"
      },
      "idle_inhibitor": {
          "format": "{icon}",
          "format-icons": {
              "activated": "",
              "deactivated": ""
          }
      },
      "tray": {
          // "icon-size": 21,
          "spacing": 10
      },
      "clock": {
          "tooltip-format": "<big>  {:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
          "format-alt": "  {:%Y-%m-%d}"
      },
      "cpu": {
          "format": " {usage}%",
          "tooltip": true
      },
      "memory": {
          "format": " {}%"
      },
      "backlight": {
          "format": "{icon} {percent}%",
          "format-icons": ["", ""]
      },
      "battery": {
          "states": {
              // "good": 95,
              "warning": 30,
              "critical": 15
          },
          "format": "{icon} {capacity}%",
          "format-charging": " {capacity}%",
          "format-plugged": " {capacity}%",
          "format-alt": "{icon} {time}",
          "format-icons": ["", "", "", "", ""]
      },
      "battery#bat2": {
          "bat": "BAT2"
      },
      "network": {
          // "interface": "wlp2*", // (Optional) To force the use of this interface
          "format-wifi": "  {essid} ({signalStrength}%)",
          "format-ethernet": "{ifname}: {ipaddr}/{cidr}",
          "format-linked": "{ifname} (No IP)",
          "format-disconnected": "  Disconnected",
          "format-alt": "{ifname}: {ipaddr}/{cidr}"
      },
      "pulseaudio": {
          // "scroll-step": 1, // %, can be a float
          "format": "{volume}% {format_source}",
          "format-bluetooth": "{volume}% {icon} {format_source}",
          "format-bluetooth-muted": " {icon} {format_source}",
          "format-muted": " {format_source}",
          "format-source": "| Mic : {volume}%",
          "format-source-muted": "",
          "format-icons": {
              "hands-free": "",
              "headset": "",
              "phone": "",
              "portable": "",
              "car": "",
              "headphone": [" Vol :", "  Vol :", "  Vol :"]
          },
          "on-click": "pavucontrol"
      },
      "custom/media": {
          "format": "{icon} {}",
          "return-type": "json",
          "max-length": 40,
          "format-icons": {
              "spotify": "",
              "default": "🎜"
          },
          "escape": true,
          "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null" // Script in resources folder
          // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
      }
  }

''
