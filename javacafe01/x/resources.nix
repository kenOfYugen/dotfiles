{ theme }:

with theme.colors;

''
  Xft.dpi: 96
  Xft.antialias: true
  Xft.hinting: true
  Xft.rgba: rgb
  Xft.autohint: false
  Xft.hintstyle: hintslight
  Xft.lcdfilter: lcddefault

  ! special
  *.foreground:   #${fg}
  *.background:   #${bg}
  *.cursorColor:  #${lbg}

  ! black
  *.color0:       #${c0}
  *.color8:       #${c8}

  ! red
  *.color1:       #${c1}
  *.color9:       #${c9}

  ! green
  *.color2:       #${c2}
  *.color10:      #${c10}

  ! yellow
  *.color3:       #${c3}
  *.color11:      #${c11}

  ! blue
  *.color4:       #${c4}
  *.color12:      #${c12}

  ! magenta
  *.color5:       #${c5}
  *.color13:      #${c13}

  ! cyan
  *.color6:       #${c6}
  *.color14:      #${c14}

  ! white
  *.color7:       #${c7}
  *.color15:      #${c15}
''
