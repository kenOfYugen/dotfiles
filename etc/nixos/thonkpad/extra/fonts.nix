{ pkgs, ... }:
{

  fonts = { 
    fonts = with pkgs; [
      nerdfonts
      sarasa-gothic
      emacs-all-the-icons-fonts
      noto-fonts-emoji-blob-bin 
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Sarasa Mono K" ];        
        sansSerif = [ "Sarasa UI K" ];
        serif     = [ "Sarasa UI K" ];
        emoji = [ "Blobmoji" ];
      };
    }; 
  };

}
