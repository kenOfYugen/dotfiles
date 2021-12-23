{ pkgs, ... }:
''
  (defwindow panel
    :monitor 0
    :geometry (geometry :x "15px"
    :y "15px"
    :width "380px"
    :height "200px"
    :anchor "top left")
    :stacking "fg"
    (sidebar))

  (defwidget sidebar []
    (box :class "sidebar"
         :orientation "v"
         :spacing 0
         :space-evenly "false"
      (media-info)   
      (power-menu)))

  (defwidget media-info []
    (box :class "media"
         :spacing 10
         :space-evenly "false"
      (button :onclick "${pkgs.playerctl}/bin/playerctl play-pause"
        (image :path "''${art}"
               :class "image"
               :image-width 50))
      (label :text "''${metadata}"
             :class "metadata"
             :wrap "true")))

  (defwidget power-menu []
    (box :class "power-menu"
      :spacing 15
      :space-evenly "true"
      (button :onclick "systemctl poweroff"
        (label :class "power-poweroff"
               :text ""))
                         (button :onclick "systemctl reboot"
      (label :class "power-icon"
             :text "ﰇ"))
                       (button :onclick "$HOME/.local/bin/lock.sh"
    (label :class  "power-icon"
           :text ""))
  (button :onclick "swaymsg exit"
    (label :class "power-icon"
           :text ""))
  (button :onclick "systemctl suspend"
    (label :class "power-icon"
           :text "⏾"))))

  ;; Variables
  (defpoll metadata :interval "5s"
    "${pkgs.playerctl}/bin/playerctl metadata --format '{{ artist }} - {{ title }}'")

  (defpoll art :interval "5s"
    `$HOME/.local/bin/art.sh "$(${pkgs.playerctl}/bin/playerctl metadata mpris:artUrl)"`)
''
