# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./extra/fonts.nix
    ./extra/amdgpu.nix
    ./extra/vscode.nix
   # ./extra/gaming.nix
  ];

  nix = {
    binaryCaches =
      [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];

    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
    kernelPackages = pkgs.linuxPackages_xanmod;
    cleanTmpDir = true;

    kernelParams = [
      "acpi_rev_override"
      "mem_sleep_default=deep"
      # "intel_iommu=igfx_off"
      # "nvidia-drm.modeset=1"
    ];

    loader = {
      grub.enable = false;
      systemd-boot.enable = true;

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
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
      enp5s0.useDHCP = true;
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

  services = {
    blueman.enable = true;
    printing.enable = true;
    tlp.enable = false;
    upower.enable = true;
    openssh.enable = true;
    acpid.enable = true;
    thermald.enable = false;
    gvfs.enable = true;

    xserver = {
      enable = true;
      useGlamor = true;
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
          enable = true;

          luaModules = with pkgs; [
            lua52Packages.lgi
            lua52Packages.ldbus
            lua52Packages.luarocks-nix
            lua52Packages.luadbi-mysql
            lua52Packages.luaposix
          ];
        };
      };
    };

    dbus = {
      packages = let
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
      in with pkgs; [ gnome3.dconf mopidyDbusServiceFile ];

      enable = true;
    };

    mopidy = {
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

    picom = {
      enable = true;
      experimentalBackends = true;
      backend = "glx";
      vSync = true;
      shadow = true;
      shadowOffsets = [ (-18) (-18) ];
      shadowOpacity = 0.4;

      settings = {
        animations = true;
        animation-stiffness = 300;
      };

      shadowExclude = [
        "class_g = 'slop'"
        "window_type = 'menu'"
        "class_g = 'Firefox' && window_type *= 'utility'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      wintypes = {
        popup_menu = { full-shadow = true; };
        dropdown_menu = { full-shadow = true; };
        notification = { shadow = true; full-shadow = true; };
        normal = { full-shadow = true; };
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
      st
      acpid
      dbus
      master.wezterm
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
      nixfmt
      pkg-config
      iw
      lm_sensors
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
  };

  virtualisation.docker.enable = true;

  vscode.user = "javacafe01";
  vscode.homeDir = "/home/javacafe01";
  vscode.extensions = with pkgs.vscode-extensions;
    [
      matklad.rust-analyzer
      pkief.material-icon-theme
      editorconfig.editorconfig
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "nix-ide";
      publisher = "jnoortheen";
      version = "0.1.16";
      sha256 = "sha256-d/U2neLVDZjCgpsGYA2kvmAmXyW/67F5riFL6X8NfhI=";
    }];

  system = {
    stateVersion = "21.05";
    userActivationScripts.clone-nvchad.text = ''
      ${pkgs.git}/bin/git clone https://github.com/NvChad/NvChad ~/.config/nvim || true
    '';
  };

  xdg.portal.enable = true;
}
