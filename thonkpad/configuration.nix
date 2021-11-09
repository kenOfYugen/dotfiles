# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./extra/fonts.nix
    ./extra/nvidia.nix
    # ./extra/gaming.nix
  ];

  nix = {
    binaryCaches = [
      "https://cache.nixos.org?priority"
      "https://cache.ngi0.nixos.org/"
      "https://mjlbach.cachix.org"
      "https://nix-community.cachix.org"
      "https://fortuneteller2k.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];

    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
      "mjlbach.cachix.org-1:dR0V90mvaPbXuYria5mXvnDtFibKYqYc2gtl9MWSkqI="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];

    trustedUsers = [ "root" "javacafe01" ];
    package = pkgs.nixUnstable;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    allowedUsers = [ "javacafe01" ];
    autoOptimiseStore = true;
    checkConfig = true;

    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;
    useSandbox = false;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_lqx;
    cleanTmpDir = true;

    kernelParams = [
      "acpi_rev_override"
      "mem_sleep_default=deep"
      "intel_iommu=igfx_off"
      "nvidia-drm.modeset=1"
    ];

    loader = {
      grub = {
        enable = true;
        version = 2;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };

      efi = { canTouchEfiVariables = true; };
    };
  };

  networking = {
    hostName = "thonkpad";
    wireless.iwd.enable = true;
    wireless.enable = false;
    useDHCP = false;

    networkmanager = {
      enable = true;
      dns = "none";
      wifi.backend = "iwd";
    };

    interfaces = {
      enp0s31f6.useDHCP = true;
      wlan0.useDHCP = true;
    };
  };

  time.timeZone = "America/Los_Angeles";

  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security.rtkit.enable = true;

  services = {
    blueman.enable = true;
    printing.enable = true;
    tlp.enable = true;
    upower.enable = true;
    openssh.enable = true;
    acpid.enable = true;
    thermald.enable = true;
    gvfs.enable = true;

    /*
      pipewire = {
      enable = false;

      alsa = {
      enable = true;
      support32Bit = true;
      };

      jack.enable = true;
      pulse.enable = true;

      config = import ./extra/pipewire;
      media-session.config = import ./extra/pipewire/media-session.nix;
      media-session.enable = true;
      };
    */

    xserver = {
      enable = true;
      useGlamor = true;
      layout = "us";
      dpi = 96;
      libinput.enable = true;

      displayManager = {
        gdm = {
          enable = true;
          autoSuspend = false;

          wayland = true;
          nvidiaWayland = true;
        };

        autoLogin = {
          enable = true;
          user = "javacafe";
        };

        defaultSession = "none+awesome";

      };

      windowManager = {
        awesome = {
          enable = true;

          luaModules = with pkgs; [
            luajitPackages.lgi
            luajitPackages.ldbus
            luajitPackages.luadbi-mysql
            luajitPackages.luaposix
          ];
        };
      };
    };

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

    greetd = {
      enable = false;

      settings = {
        default_session.command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'sway --my-next-gpu-wont-be-nvidia'";

        initial_session = {
          command = "sway --my-next-gpu-wont-be-nvidia";
          user = "javacafe01";
        };
      };
    };

    mopidy = {
      enable = true;
      extensionPackages = with pkgs; [ mopidy-mpris mopidy-mpd ];
      configuration = ''
        [mpris]
        bus_type = system

        [audio]
        output = pulsesink server=127.0.0.1
      '';
    };

    picom = {
      enable = true;
      experimentalBackends = true;
      backend = "xrender";
      vSync = true;
      shadow = true;
      shadowOffsets = [ (-18) (-18) ];
      shadowOpacity = 0.4;

      shadowExclude = [
        "class_g = 'slop'"
        "window_type = 'menu'"
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'Firefox' && window_type *= 'utility'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      wintypes = {
        popup_menu = { full-shadow = true; };
        dropdown_menu = { full-shadow = true; };
        notification = { full-shadow = true; };
        normal = { full-shadow = true; };
      };

      settings = {
        corner-radius = 6;
        rounded-corners-exclude = [
          "!window_type = 'normal' && !window_type = 'notification'"
        ];
      };

    };

  };
  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      daemon.config.avoid-resampling = "yes";
      support32Bit = true;

      tcp = {
        enable = true;
        anonymousClients.allowedIpRanges = [ "127.0.0.1" ];
      };

      extraModules = [ pkgs.pulseaudio-modules-bt ];

      package = pkgs.pulseaudioFull;

      extraConfig = "\n    load-module module-switch-on-connect\n    ";
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [ amdvlk rocm-opencl-icd rocm-opencl-runtime ];

      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };

    bluetooth.enable = true;
    bluetooth.package = pkgs.bluezFull;
  };

  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;

    users.javacafe01 = {
      isNormalUser = true;
      home = "/home/javacafe01";
      description = "Gokul Swaminathan";
      extraGroups = [
        "wheel"
        "networkmanager"
        "sudo"
        "video"
        "audio"
        "docker"
        "mopidy"
        "adbusers"
      ];
    };
  };

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    variables = { "EDITOR" = "vim"; };
    systemPackages = with pkgs; [
      acpid
      dbus
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
      gcc
      imagemagick
      slop
      libnotify
      inotify-tools
      brightnessctl
      fzf
      pamixer
      slop
      xclip
      niv
      acpi
      fd
      (ripgrep.override { withPCRE2 = true; })
      gnutls
      libtool
      cmake
      pkg-config
      iw
      lm_sensors
      psmisc
      # pulseaudio
      alsaTools
      alsaUtils
    ];
  };

  programs = {
    nm-applet.enable = true;
    mtr.enable = true;
    adb.enable = true;
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    dconf.enable = true;

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

    qt5ct.enable = true;
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "21.05";

  xdg.portal.enable = true;
}
