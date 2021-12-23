{ pkgs, ... }:

''
  (include "./panel.yuck")
  (include "./cal.yuck")


  (defwindow bar
    :monitor 0
    :geometry (geometry :x "0px"
    :y "0px"
    :width "100%"
    :height "35px"
    :anchor "top center")
    :stacking "bottom"
    :exclusive "true"
    (main-bar))

  ;; Main-bar body    
  (defwidget main-bar []
    (centerbox :orientation "horizontal"
               :class "main-bar"
      (temp)
      (workspaces)
      (right-side)))

  ;; Widgets

  (defwidget workspaces []
    (box :class "workspaces"
         :halign "center"
         :valign "center"
         :orientation "horizontal"
         :spacing 22
         :space-evenly "false"
      (button ;:class "''${ws1} ?1"
               :onclick "swaymsg workspace number 1"
        "''${wspc1}")
      (button ;:class "''${ws2} ?2"
               :onclick "swaymsg workspace number 2"
        "''${wspc2}")
      (button ;:class "''${ws3} ?3"
               :onclick "swaymsg workspace number 3"
        "''${wspc3}")
      (button ;:class "''${ws4} ?4"
               :onclick "swaymsg workspace number 4"
        "''${wspc4}")

      (button ;:class "''${ws5} ?5"
               :onclick "swaymsg workspace number 5"
        "''${wspc5}")))

  (defwidget right-side []
    (box :class "right-side"
         :halign "end"
         :valign "center"
         :spacing 10
         :space-evenly "false"
      (network)
      (volume)
      (light)
      (battery)
      (date)))

  (defwidget volume []
    (box  :class "volume"
          :spacing 0
          :space-evenly "false"
      (button :onclick "pavucontrol &"
        (label :text "''${vol-icon}"
               :class "vol-icon"))
      (scale :value "''${volume}"
             :min 0
             :max 101
             :class "volume-bar"
             :valign "center"
             :halign "center"
             :tooltip "''${volume}")))

  (defwidget light []
    (box :class "light"
         :spacing 0
         :space-evenly "false"
      ""
      (scale :value "''${light}"
             :min 0
             :max 512
             :class "light-bar"
             :onchange "brightnessctl s {}"
             :valign "center"
             :tooltip "''${light}")))

  (defwidget battery []
    (box :class "battery"
         :spacing 1
         :space-evenly "false"
         :tooltip {EWW_BATTERY.BAT0.capacity}
      (label :text {EWW_BATTERY.BAT0.status == "Charging" ? "" : ""}
             :class "battery-icon")
      (scale :value {EWW_BATTERY.BAT0.capacity}
             :min 0
             :max 101
             :class "battery-bar"
             :valign "center"
             :halign "center")))

  (defwidget network []
    (eventbox :onhover "eww update network_toggle=true"
              :onhoverlost "eww update network_toggle=false"
      (box :class "network"
           :spacing 10
           :space-evenly "false"
           :halign "center"
        (label :onrightclick "nm-connection-editor &"
               :class "network-icon"
               :text "")
        (revealer :duration "300ms"
                  :reveal "''${network_toggle}"
                  :transition "slideleft"
          (label :text "''${network}"
                 :class "network-ssid")))))

  (defwidget date []
    (eventbox :onhover "eww update date_toggle=true"
              :onhoverlost "eww update date_toggle=false"
      (box :class "date"
           :spacing 10
           :space-evenly "false"
        (label :text " ''${date}"
               :class "time")
        (revealer :duration "300ms"
                  :transition "slideright"
                  :reveal "''${date_toggle}"
          (button :onclick "eww open cal_pop"
                  :onrightclick "eww close cal_pop"
            (label :text "''${date_alt}"
                   :class "date_alt"))))))

  (defwidget temp []
    (button :onclick "eww open panel"
            :halign "start"
            :valign "center"
            :onrightclick "eww close panel"
      (image :path "/etc/nixos/config/awesome/images/distro.png"
             :image-width 16
             :image-height 16
             :class "launcher-icon")))

  ;; Variables

  (defvar media_toggle false)

  (defvar network_toggle false)

  (defvar date_toggle false)

  ;; Polling variables

  (defpoll wspc1 :interval "500ms"
    `swaymsg -t get_workspaces | ${pkgs.jq}/bin/jq -r '.[0] | .name // "-" '`)

  (defpoll wspc2 :interval "500ms"
    `swaymsg -t get_workspaces | ${pkgs.jq}/bin/jq -r '.[1] | .name // "-" '`)

  (defpoll wspc3 :interval "500ms"
    `swaymsg -t get_workspaces | ${pkgs.jq}/bin/jq -r '.[2] | .name // "-" '`)

  (defpoll wspc4 :interval "500ms"
    `swaymsg -t get_workspaces | ${pkgs.jq}/bin/jq -r '.[3] | .name // "-" '`)

  (defpoll wspc5 :interval "500ms"
    `swaymsg -t get_workspaces | ${pkgs.jq}/bin/jq -r '.[4] | .name // "-" '`)

  (defpoll vol-icon :interval "100ms"
    "$HOME/.local/bin/volume.sh")

  (defpoll volume :interval "500ms"
    "${pkgs.pamixer}/bin/pamixer --get-volume")

  (defpoll light :interval "500ms"
    "${pkgs.brightnessctl}/bin/brightnessctl g")

  (defpoll network :interval "15s"
    "$HOME/.local/bin/network.sh")

  (defpoll date :interval "30s"
    "date +%H:%M")

  (defpoll date_alt :interval "9h"
    "date +'%b %e'")
''
