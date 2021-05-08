{ pkgs, ... }:
{
  
  fonts.fonts = with pkgs; [
    cantarell_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    nerdfonts
    sarasa-gothic
  ];
 
  fonts.fontconfig = {
    dpi = 240;
    # penultimate.enable = false;
    defaultFonts = {
      monospace = [ "Noto Sans Mono Regular" ];        
      sansSerif = [ "Noto Sans Display Regular" ];
      serif     = [ "Noto Serif Regular" ];
    };
  };  
}
