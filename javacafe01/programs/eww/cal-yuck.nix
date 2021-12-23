{}:
''
  (defwindow cal_pop
    :monitor 0
    :geometry (geometry :x "15px"
    :y "15px"
    :width "370px"
    :height "340px"
    :anchor "top right")
    :stacking "fg"
    (cal))

  (defwidget cal []
    (calendar :class "calendar"
              :year 2021
              :month 12
      ))
''
