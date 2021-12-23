{ config, pkgs, lib, ... }:

let

  theme = import ../theme/theme.nix { };
in
{

  fonts.fontconfig.enable = true;

  home = {
    username = "javacafe01";
    homeDirectory = "/home/javacafe01";

    file = {
      # AwesomeWM Config
      # ".config/awesome".source = ../config/awesome;

      # Waybar Configs
      ".config/waybar/config".text = import ./programs/waybar/modules.nix { };
      ".config/waybar/style.css".text = import ./programs/waybar/style.nix { inherit theme; };

      # Sworkstyle Config
      ".config/sworkstyle/config.toml".text = import ./programs/sworkstyle.nix { };

      # Eww Configs
      ".config/eww/eww.yuck".text = import ./programs/eww/eww-yuck.nix { inherit pkgs; };
      ".config/eww/eww.scss".text = import ./programs/eww/eww-scss.nix { inherit theme; };
      ".config/eww/panel.yuck".text = import ./programs/eww/panel-yuck.nix { inherit pkgs; };
      ".config/eww/cal.yuck".text = import ./programs/eww/cal-yuck.nix { };

      # Bin Scripts
      ".local/bin/jeff" = {
        # X11 Recorder
        executable = true;
        text = import ./bin/jeff.nix { inherit pkgs; };
      };

      ".local/bin/shoot" = {
        # X11 Screenshots
        executable = true;
        text = import ./bin/shoot.nix { inherit pkgs; };
      };

      ".local/bin/updoot" = {
        # Upload and get link
        executable = true;
        text = import ./bin/updoot.nix { inherit pkgs; };
      };

      ".local/bin/preview.sh" = {
        # Preview script for fzf tab
        executable = true;
        text = import ./bin/preview.nix { inherit pkgs; };
      };

      ".local/bin/art.sh" = {
        # Eww art script
        executable = true;
        text = import ./bin/eww-art.nix { inherit pkgs; };
      };

      ".local/bin/network.sh" = {
        # Eww network script
        executable = true;
        text = import ./bin/eww-network.nix { inherit pkgs; };
      };

      ".local/bin/volume.sh" = {
        # Eww volume script
        executable = true;
        text = import ./bin/eww-volume.nix { inherit pkgs; };
      };
    };

    sessionPath = [
      "${config.xdg.configHome}/emacs/bin"
      "${config.home.homeDirectory}/.local/bin"
    ];

    sessionVariables = {
      BROWSER = "${pkgs.brave}/bin/brave";
      EDITOR = "${config.programs.nixvim.package}/bin/nvim";
      GOPATH = "${config.home.homeDirectory}/Extras/go";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      RUSTUP_HOME = "${config.home.homeDirectory}/.local/share/rustup";

      XDG_SESSION_DESKTOP = "sway";
      SDL_VIDEODRIVER = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      MOZ_ENABLE_WAYLAND = "1";
      CLUTTER_BACKEND = "wayland";
      NO_AT_BRIDGE = "1";
    };

    packages = with pkgs; [

      # Programs
      playerctl
      zoom-us
      gimp
      arandr
      gnome3.nautilus
      gnome3.eog
      google-chrome
      feh
      evince
      manix
      sqlite
      pandoc
      glxinfo
      trash-cli
      eww-way # Eww compiled for wayland

      # Language servers
      sumneko-lua-language-server
      nodePackages.bash-language-server
      rust-analyzer
      rustfmt
      nodePackages.pyright
      python-language-server
      nodePackages.vim-language-server
      ccls
      texlive.combined.scheme-medium
      rnix-lsp
      shfmt

      teal-lang

      # Formatters
      (import ../derivations/luaFormatter.nix {
        inherit stdenv fetchFromGitHub pkgs;
      })
      black

      editorconfig-core-c
      glslang

      gocode
      gomodifytags
      gotests
      gore

      ktlint
      nixfmt
      maim

      python39
      python39Packages.pyflakes
      python39Packages.isort
      pipenv
      python39Packages.pytest

      rustc
      cargo

      shellcheck

      neovide

      unclutter-xfixes # Hides mouse cursor when using touch screen

      spotdl

      # pkgs for Wayland
      peek
      swappy
      autotiling
      swaylock
      swayidle
      swaybg
      wayland-utils
      waybar
      wl-clipboard
      wf-recorder
      brightnessctl
      grim
      slurp
      sway-contrib.grimshot
      qt5.qtwayland
      xdg-desktop-portal-wlr
      river
      kile-wl
      xdg_utils
      wayfire
      wdisplays
      wtype
      wlogout
      sworkstyle

      mpc_cli
      geoclue2
      gammastep
      light
      jq
    ];
  };

  programs = {
    alacritty = {
      enable = true;
      package = pkgs.master.alacritty;
      settings = import ./programs/alacritty.nix { inherit theme; };
    };

    bat = {
      enable = true;
      config = {
        pager = "never";
        style = "plain";
        theme = "base16";
      };
    };

    brave = {
      enable = true;
      package = pkgs.brave;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    discocss = {
      enable = true;
      discord = pkgs.discord;
      discordAlias = true;
      css = import ./programs/discord-css.nix { inherit theme; };
    };

    emacs = {
      enable = false;
      package = pkgs.emacsPgtkGcc;
      extraPackages = epkgs: [ epkgs.vterm ];
    };

    exa = {
      enable = true;
      enableAliases = false;
    };

    firefox = {
      enable = true;

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        stylus
      ];

      profiles = {
        myprofile = {
          id = 0;
          settings = {
            "browser.startup.homepage" = "https://gs.is-a.dev/startpage/";
            "general.smoothScroll" = true;
          };

          userChrome = import ./programs/firefox/userChrome-css.nix { inherit theme; };
          userContent = import ./programs/firefox/userContent-css.nix { inherit theme; };

          extraConfig = ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("full-screen-api.ignore-widgets", true);
          '';
        };

        chat = {
          id = 1;
          settings = { "general.smoothScroll" = true; };
          userChrome = import ./programs/firefox/userChrome-css.nix { inherit theme; };
          userContent = import ./programs/firefox/userContent-css.nix { inherit theme; };

          extraConfig = ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("full-screen-api.ignore-widgets", true);
          '';
        };
      };
    };

    foot = {
      enable = true;
      settings = import ./programs/foot.nix { inherit theme; };
    };

    git = {
      enable = true;
      userName = "Gokul Swaminathan";
      userEmail = "gokulswamilive@gmail.com";
    };

    home-manager = {
      enable = true;
      path = "…";
    };

    mako = {
      enable = true;
      anchor = "top-right";
      backgroundColor = "#${theme.colors.dbg}";
      borderColor = "#${theme.colors.dbg}";
      borderSize = 0;
      padding = "20";
      borderRadius = 6;
      defaultTimeout = 5000;
    };

    mpv = {
      enable = true;
    };

    ncspot = {
      enable = true;
    };

    nixvim = {
      enable = true;
      package = pkgs.neovim-nightly;
      colorscheme = "javacafe";
      plugins.gitgutter.enable = true;
      plugins.telescope.enable = true;

      plugins.lualine = {
        enable = false;
      };

      plugins.lspsaga = {
        enable = true;
        borderStyle = "rounded";
      };

      /*
        plugins.lsp = {
        enable = true;
        servers = {
        pyright.enable = true;
        rnix-lsp.enable = true;
        rust-analyzer.enable = true;
        clangd.enable = true;
        };
        };
      */

      plugins.treesitter = {
        enable = true;
        ensureInstalled = [ "nix" "lua" "bash" "c" "cpp" "css" "go" "rust" "html" "vim" "typescript" "python" ];
      };

      extraPlugins = with pkgs.vimPlugins; [ vim-nix ] ++ [ pkgs.themer-lua-nvim ];

      extraConfigLua = ''

        local opt = vim.opt
        local g = vim.g

        opt.fillchars = { eob = " " }


        -- Theme Plugin
        require("themer").setup({
          colorscheme = "javacafe",
          integrations = {
            treesitter = true,
          },
          extra_integrations = {
            lualine = true,
          },
        })


             '';

      options = {
        number = true;
        relativenumber = true;
        mouse = "a";
        clipboard = "unnamedplus";

      };

      globals.mapleader = " ";
    };

    rofi = {
      enable = true;
      package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };

      extraConfig = {
        show-icons = true;
      };

      theme = import ./programs/rofi-theme.nix { inherit config theme; };
    };

    starship = {
      enable = true;
      settings = import ./programs/starship.nix;
    };

    zsh = {
      enable = true;
      autocd = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      dotDir = ".config/zsh";

      shellAliases = {
        ls = "exa --color=auto --icons";
        l = "ls -l";
        la = "ls -a";
        lla = "ls -la";
        lt = "ls --tree";
        cat = "bat --color always --plain";
        grep = "grep --color=auto";
        c = "clear";
        v = "nvim";
        xwin = "Xephyr -br -ac -noreset -screen 960x600 :1";
        xdisp = "DISPLAY=:1";
        rm = "${pkgs.trash-cli}/bin/trash-put";
      };

      initExtra = ''
        set -k
        setopt auto_cd
        export PATH="''${HOME}/.local/bin:''${HOME}/go/bin:''${HOME}/.emacs.d/bin:''${HOME}/.npm/bin:''${HOME}/.cargo/bin:''${PATH}"
        setopt NO_NOMATCH   # disable some globbing 

        function run() {
          nix run nixpkgs#$@
        }

        precmd() {
          printf '\033]0;%s\007' "$(dirs)"
        }

        command_not_found_handler() {
          printf 'Command not found ->\033[32;05;16m %s\033[0m \n' "$0" >&2
          return 127
                                                           }

        export SUDO_PROMPT=$'Password for ->\033[32;05;16m %u\033[0m  '

        export FZF_DEFAULT_OPTS='
        --color fg:#ffffff,bg:#131a21,hl:#A3BE8C,fg+:#D8DEE9,bg+:#131A21,hl+:#A3BE8C,border:#3b4b58
        --color pointer:#f9929b,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#9ce5c0,marker:#EBCB8B
        '

        FZF_TAB_COMMAND=(
          ${pkgs.fzf}/bin/fzf
          --ansi
          --expect='$continuous_trigger' # For continuous completion
          --nth=2,3 --delimiter='\x00'  # Don't search prefix
          --layout=reverse --height="''${FZF_TMUX_HEIGHT:=50%}"
          --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-space:toggle --cycle
          '--query=$query'   # $query will be expanded to query string at runtime.
          '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
        )
          zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND

          zstyle ':completion:complete:*:options' sort false
          zstyle ':fzf-tab:complete:_zlua:*' query-string input

          zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview.sh $realpath'
      '';

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        save = 50000;
      };

      plugins = with pkgs; [
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions-src;
        }
        {
          name = "fzf-tab";
          src = pkgs.fzf-tab-src;
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting-src;
          file = "zsh-syntax-highlighting.zsh";
        }
      ];
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    mpd = {
      enable = true;
      package = pkgs.master.mpd;
      musicDirectory = config.xdg.userDirs.music;
      extraConfig = import ./programs/mpd.nix { };
    };

    mpdris2 = {
      enable = config.services.mpd.enable;
      multimediaKeys = true;
      notifications = true;
    };

    playerctld.enable = true;
  };

  systemd.user = {
    startServices = true;

    targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.phocus;
      name = "phocus";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font.name = "Sarasa UI K 10";
  };

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway-git;

    config = with theme.colors; {
      bars = [
      ];
      keybindings = { };
    };

    extraConfig = import ./programs/sway.nix { inherit pkgs theme; };

    wrapperFeatures.gtk = true;
  };

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      documents = "${config.home.homeDirectory}/Documents";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
    };
  };

  xresources.extraConfig = import ./x/resources.nix { inherit theme; };
}
