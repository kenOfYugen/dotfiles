{ pkgs, ... }: {

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;

    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      sarasa-gothic
      noto-fonts-emoji-blob-bin
      emacs-all-the-icons-fonts
      cantarell-fonts
      bitmap-font-collections
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Sarasa Mono K" ];
        sansSerif = [ "Sarasa UI K" ];
        serif = [ "Sarasa UI K" ];
        emoji = [ "Blobmoji" ];
      };
    };
  };

}
