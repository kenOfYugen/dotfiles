{ config, pkgs, lib, ... }: {
  programs.steam.enable = true;
  hardware.steam-hardware.enable =
    true; # Provides udev rules for controller, HTC vive, and Valve Index

  hardware.xpadneo.enable = true;

  services.hardware.xow.enable = true;

  services.xserver.modules = [ pkgs.xlibs.xf86inputjoystick ];

  environment.systemPackages = with pkgs; [
    lutris
    (steam.override { withJava = true; })
    (steam.override { nativeOnly = true; }).run
    (winetricks.override { wine = wineWowPackages.staging; })
  ];
}
