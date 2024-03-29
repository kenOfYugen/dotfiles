# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let theme = import ../theme/theme.nix { };
in
{
  imports = [
    ./hardware-configuration.nix
    ./extra/fonts.nix
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
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "ideapad_laptop" ];
    kernelModules = [ "acpi_call" ];
    kernel.sysctl."vm.swappiness" = 1;
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    initrd.kernelModules = [ "i915" ];
    cleanTmpDir = true;

    kernelParams = [
      "acpi_rev_override"
      "mem_sleep_default=deep"
      "acpi_backlight=vendor"
    ];

    loader = {
      grub = {
        enable = true;
        version = 2;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };

      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "thonkpad";
    firewall.enable = true;
    wireless.iwd.enable = true;
    wireless.enable = false;
    useDHCP = false;

    networkmanager = {
      enable = true;
      dns = "none";
      wifi.backend = "iwd";
    };

    interfaces = {
      wlan0.useDHCP = true;
    };
  };

  time.timeZone = "America/Los_Angeles";

  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";

  console =
    let
      normal = with theme.colors; [ bg c1 c2 c3 c4 c5 c6 c7 ];
      bright = with theme.colors; [ lbg c9 c10 c11 c12 c13 c14 c15 ];
    in
    {
      colors = normal ++ bright;
      font = "Lat2-Terminus16";
      keyMap = "us";
    };

  security.rtkit.enable = true;

  services = {
    blueman.enable = true;
    printing.enable = true;
    tlp.enable = true;
    fprintd.enable = true;
    upower.enable = true;
    openssh.enable = true;
    acpid.enable = true;
    thermald.enable = true;
    throttled.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    fstrim.enable = true;

    pipewire = {
      enable = true;

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

    xserver = {
      enable = true;
      useGlamor = true;
      layout = "us";
      dpi = 96;
      wacom.enable = true;

      libinput = {
        enable = true;
        touchpad.tapping = false;
      };

      displayManager = {
        lightdm = {
          enable = true;
        };

        autoLogin = {
          enable = true;
          user = "javacafe01";
        };

        defaultSession = "none+awesome";

      };

      windowManager = {
        awesome = {
          enable = true;

          luaModules = with pkgs.luajitPackages; [
            lgi
            ldbus
            luadbi-mysql
            luaposix
          ];
        };
      };
    };

    dbus = {
      enable = true;
    };

    greetd = {
      enable = false;

      settings = {
        default_session.command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'sway'";

        initial_session = {
          command = "sway";
          user = "javacafe01";
        };
      };
    };

    picom = {
      enable = true;
      experimentalBackends = true;
      backend = "glx";
      vSync = true;
      shadow = false;
      shadowOffsets = [ (-18) (-18) ];
      shadowOpacity = 0.3;

      shadowExclude = [
        "class_g = 'slop'"
        "window_type = 'menu'"
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'Firefox' && window_type *= 'utility'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      opacityRules = [
        "85:class_g = 'splash'"
      ];

      wintypes = {
        popup_menu = { full-shadow = true; };
        dropdown_menu = { full-shadow = true; };
        notification = { full-shadow = true; };
        normal = { full-shadow = true; };
      };

      settings = {
        # animations = true;

        corner-radius = 0;
        rounded-corners-exclude = [
          "!window_type = 'normal'"
        ];

        blur-method = "dual_kawase";
        blur-strength = 8.0;
        kernel = "11x11gaussian";
        blur-background = false;
        blur-background-frame = true;
        blur-background-fixed = true;

        blur-background-exclude = [
          "!window_type = 'splash'"
        ];

        daemon = false;
        dbus = false;
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        glx-no-stencil = true;
        use-damage = true;
        resize-damage = 1;
        transparent-clipping = false;
      };

    };

  };
  sound.enable = true;

  hardware = {
    sensor.iio.enable = true;
    pulseaudio = {
      enable = false;
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

    cpu = {
      intel.updateMicrocode = true;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
      ];
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
      pulseaudio
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

  system = {
    stateVersion = "22.05";
  };

  xdg.portal.enable = true;
}
