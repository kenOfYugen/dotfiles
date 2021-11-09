{ pkgs, theme }:

with theme.colors;

''
  exec ${pkgs.autotiling}/bin/autotiling
  exec ${pkgs.mako}/bin/mako
  
  # modkey
  set $mod Mod4

  # Use Mouse+$mod to drag floating windows to their wanted position
  floating_modifier $mod

  # start a terminal
  set $term alacritty
  bindsym $mod+t exec $term

  # spawn menu
  set $menu "${pkgs.rofi}/bin/rofi -show drun"
  bindsym $mod+d exec $menu

  # change focus
  bindsym $mod+Left focus left
  bindsym $mod+Down focus down
  bindsym $mod+Up focus up
  bindsym $mod+Right focus right

  # move focused window
  bindsym $mod+Shift+Left move left
  bindsym $mod+Shift+Down move down
  bindsym $mod+Shift+Up move up
  bindsym $mod+Shift+Right move right

  # split in horizontal orientation
  bindsym $mod+c splith

  # split in vertical orientation
  bindsym $mod+v splitv

  bindsym $mod+shift+w layout tabbed

  # enter fullscreen mode for the focused container
  bindsym $mod+shift+f fullscreen toggle

  bindsym $mod+shift+e layout toggle split



  # toggle tiling / floating
  bindsym $mod+shift+t floating toggle

  # kill focused window
  bindsym $mod+q kill

  font "pango:Sarasa Mono K 5"

  # Window rules
  for_window [window_role="pop-up"]      floating enable
  for_window [window_role="bubble"]      floating enable
  for_window [window_role="task_dialog"] floating enable
  for_window [window_role="Preferences"] floating enable
  for_window [window_type="dialog"]      floating enable
  for_window [window_type="menu"]        floating enable
  for_window [window_role="task_dialog"] floating enable
  for_window [class="Gimp"]              floating enable
  for_window [class="mpv"]               floating enable
  for_window [class=".*"]                inhibit_idle fullscreen
  for_window [app_id=".*"]               title_format ""
  for_window [class=".*"]                title_format ""

  # Define names for default workspaces for which we configure key bindings later on.
  # We use variables to avoid repeating the names in multiple places.
  set $ws1 "1"
  set $ws2 "2"
  set $ws3 "3"
  set $ws4 "4"
  set $ws5 "5"
  set $ws6 "6"
  set $ws7 "7"
  set $ws8 "8"
  set $ws9 "9"
  set $ws10 "10"

  # switch to named workspace
  bindsym $mod+1 workspace number $ws1
  bindsym $mod+2 workspace number $ws2
  bindsym $mod+3 workspace number $ws3
  bindsym $mod+4 workspace number $ws4
  bindsym $mod+5 workspace number $ws5
  bindsym $mod+6 workspace number $ws6
  bindsym $mod+7 workspace number $ws7
  bindsym $mod+8 workspace number $ws8
  bindsym $mod+9 workspace number $ws9
  bindsym $mod+0 workspace number $ws10

  # switch to prev/next workspace
  bindsym ctrl+Left  workspace prev
  bindsym ctrl+Right workspace next

  # move focused container to workspace
  bindsym $mod+Shift+1 move container to workspace number $ws1
  bindsym $mod+Shift+2 move container to workspace number $ws2
  bindsym $mod+Shift+3 move container to workspace number $ws3
  bindsym $mod+Shift+4 move container to workspace number $ws4
  bindsym $mod+Shift+5 move container to workspace number $ws5
  bindsym $mod+Shift+6 move container to workspace number $ws6
  bindsym $mod+Shift+7 move container to workspace number $ws7
  bindsym $mod+Shift+8 move container to workspace number $ws8
  bindsym $mod+Shift+9 move container to workspace number $ws9
  bindsym $mod+Shift+0 move container to workspace number $ws10

  # Workspace back-and-forth
  workspace_auto_back_and_forth no

  # reload the configuration file
  bindsym $mod+Shift+r reload

  # applications shortcuts
  bindsym $mod+F2 exec emacs
  bindsym $mod+w  exec firefox

  # Volume
  bindsym XF86AudioRaiseVolume exec volume up
  bindsym XF86AudioLowerVolume exec volume down
  bindsym XF86AudioMute        exec volume toggle

  # Brightness
  bindsym XF86MonBrightnessDown exec brightnessctl -q set 10%-
  bindsym XF86MonBrightnessUp   exec brightnessctl -q set 10%+

  # Screenshot
  bindsym $mod+Print   exec grimshot copy area
  bindsym Print        exec grimshot copy active
  bindsym $mod+shift+Print   exec grimshot save screen

  bindsym $mod+Shift+q exec swaynag -t warning -m 'Do you really want to exit sway?' -b 'Yes, exit sway' 'swaymsg exit'

  default_border pixel 2
  gaps inner 0
  smart_borders off

  set $color0 #${c0}
  set $color1 #${c1}
  set $color2 #${c2}
  set $color3 #${c3}
  set $color4 #${c4}
  set $color5 #${c5}
  set $color6 #${c6}
  set $color7 #${c7}
  set $color8 #${c8}
  set $color9 #${c9}
  set $color10 #${c10}
  set $color11 #${c11}
  set $color12 #${c12}
  set $color13 #${c13}
  set $color14 #${c14}
  set $color15 #${c15}

  # class                 border    backgr    text    indicator
  client.focused          #${bg} ${dbg} $color7 ${dbg}
  client.focused_inactive #${lbg} ${dbg} $color7 ${dbg}
  client.unfocused        #${lbg} ${dbg} $color7 ${dbg}
  client.urgent           $color10 $color10 $color7 ${dbg}

  output "*" scale 1
  output "*" scale_filter nearest
  output * bg #${lbg} solid_color

  input type:touchpad {
    tap enabled
    natural_scroll enabled
  }

  input type:keyboard {
    repeat_rate 40
    repeat_delay 350
  }

  exec swayidle -w \
      timeout 300 'swaylock -c "${bg}" --font "Sarasa Gothic J"' \
      timeout 310 'swaymsg "output * dpms off"' \
      resume 'swaymsg "output * dpms on"' \
''
