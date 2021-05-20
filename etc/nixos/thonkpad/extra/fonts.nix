{ pkgs, ... }:
{
  
  fonts.fonts = with pkgs; [
    cantarell_fonts
    liberation_ttf
    nerdfonts
    sarasa-gothic
    emacs-all-the-icons-fonts
    twemoji-color-font
  ];
 
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Sarasa Mono K" ];        
      sansSerif = [ "Sarasa UI K" ];
      serif     = [ "Sarasa UI K" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };  
}
