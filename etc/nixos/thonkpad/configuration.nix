# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./extra/fonts.nix
    ./extra/nvidia.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    binaryCaches = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];

    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];    

    trustedUsers = ["root" "javacafe01"];

    package = pkgs.nixUnstable;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    allowedUsers = [ "javacafe01" ];

    autoOptimiseStore = true;

    checkConfig = true;

    gc = {
      automatic = true;
      dates = "weekly";
    };

    optimise = {
      automatic = true;
    };

    useSandbox = false;

  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    kernelParams =
      [ "acpi_rev_override" "mem_sleep_default=deep" "intel_iommu=igfx_off" "nvidia-drm.modeset=1" ];
      extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    };

    networking.hostName = "thonkpad"; # Define your hostname.
    networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
    networking.wireless.iwd.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };


  services = {
    xserver = {
      enable = true;
      layout = "us";
      dpi = 96;
      libinput.enable = true;
      displayManager = {
        lightdm = { enable = true; };
        autoLogin = {
          enable = true;
          user = "javacafe01";
        };
        defaultSession = "none+awesome";
      };
      windowManager = {

        awesome = {

          package = (pkgs.awesome.overrideAttrs (old: rec {
            version = "a4572b9b52d89369ce3bd462904d536ec116dc35";
            src = pkgs.fetchFromGitHub {
              owner = "awesomeWM";
              repo = "awesome";
              rev = "a4572b9b52d89369ce3bd462904d536ec116dc35";
              sha256 = "1kj2qz2ns0jn5gha4ryr8w8vvy23s3bb5z3vjhwwfnrv7ypb40iz";
            };
            GI_TYPELIB_PATH = "${pkgs.playerctl}/lib/girepository-1.0:" + old.GI_TYPELIB_PATH;
          })).override {
            stdenv = pkgs.clangStdenv;
            luaPackages = pkgs.lua52Packages;
            gtk3Support = true;
          };

          enable = true;

          luaModules = with pkgs.lua52Packages; [
            lgi
            ldbus
            luarocks-nix
            luadbi-mysql
            luaposix
          ];

        };
      };
    };
  };

  services = {
    dbus = {
      packages = 

      let
        mopidyDbusServiceFile = pkgs.writeTextFile rec {
          name = "org.mpris.MediaPlayer2.mopidy.conf";
          destination = "/share/dbus-1/system.d/${name}";
          text = ''
            <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
            "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
            <busconfig>
            <!-- Allow mopidy user to publish the Mopidy-MPRIS service -->
            <policy user="mopidy">
            <allow own="org.mpris.MediaPlayer2.mopidy"/>
            </policy>

            <!-- Allow anyone to invoke methods on the Mopidy-MPRIS service -->
            <policy context="default">
            <allow send_destination="org.mpris.MediaPlayer2.mopidy"/>
            <allow receive_sender="org.mpris.MediaPlayer2.mopidy"/>
            </policy>
            </busconfig>
          '';
        };
      in

      with pkgs; [ gnome3.dconf mopidyDbusServiceFile ];
      enable = true;
    };

    acpid = {
      enable = true;
    };

    connman = {
      enable = true;
      package = pkgs.connmanFull;
      wifi.backend = "iwd";
    };

    picom = {
      enable = true;
      experimentalBackends = true;
      backend = "glx";
      vSync = true;

      settings = import ./extra/picom-options.nix;
    };

  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    daemon = {
      config = {
        avoid-resampling = "yes";
      };
    };

    support32Bit = true;

    tcp = {
      enable = true;
      anonymousClients.allowedIpRanges = ["127.0.0.1"];
    };

    extraModules = [ pkgs.pulseaudio-modules-bt ];

    # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
    # Only the full build has Bluetooth support, so it must be selected here.
    package = pkgs.pulseaudioFull;

    extraConfig = "
    load-module module-switch-on-connect
    ";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  # hardware.bluetooth.config = {
  #  General = {
  #    Enable = "Source,Sink,Media,Socket";
  #  };
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = { 
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;
    users.javacafe01 = {
      isNormalUser = true;
      home = "/home/javacafe01";
      description = "Gokul Swaminathan";
      extraGroups = [ "wheel" "networkmanager" "sudo" "video" "audio" "docker" "mopidy"]; # Enable ‘sudo’ for the user.
    };
  };

  # $ nix search wget
  environment = { 

    binsh = "${pkgs.dash}/bin/dash";

    variables = {
      "EDITOR" = "nvim";
    };

    systemPackages = with pkgs; [
      dash
      acpid
      dbus
      wezterm
      pavucontrol
      wget 
      vim 
      git
      nodejs
      curl
      gnome3.librsvg
      gdk_pixbuf
      gnumake
      polkit_gnome
      google-chrome
      gsettings-desktop-schemas
      firefox
      unzip
      python3
      python38Packages.pip
      gcc
      imagemagick
      slop
      neovim-nightly
      comma
      picom
      libnotify
      inotify-tools
      brightnessctl
      fzf
      pamixer
      slop
      xclip
      cachix
      niv
      acpi
      connman-gtk
      ripgrep
      fd
    ];
  };

  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [ mopidy-spotify mopidy-mpris mopidy-mpd ];
    configuration = ''
      [mpris]
      bus_type = system

      [audio]
      output = pulsesink server=127.0.0.1

      [spotify]
      enabled = true
      client_id = <client_id>
      client_secret = <client_secret>
      username = <username>
      password = <password>
      bitrate = 320
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    mtr = {
      enable = true;
    };
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    dconf = {
      enable = true;
    };
    java = {
      enable = true;
      package = pkgs.jdk;
    };
    npm = {
      enable = true;
      npmrc = ''
        prefix = ''${HOME}/.npm
        color = true
      '';
    };
  };

  # For thinkpad
  services.tlp.enable = true;

  # Battery power management
  services.upower.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "20.09";

}
