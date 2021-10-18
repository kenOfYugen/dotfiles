{ config, pkgs, ... }:

let

  giph_wrapper =
    pkgs.writeShellScriptBin "jeff" (import ./bin/jeff.nix { inherit pkgs; });
  screenshot_script =
    pkgs.writeShellScriptBin "shoot" (import ./bin/shoot.nix { inherit pkgs; });
  panes_script = pkgs.writeShellScriptBin "panes" (import ./bin/panes.nix { });
  updoot_script = pkgs.writeShellScriptBin "updoot"
    (import ./bin/updoot.nix { inherit pkgs; });
  manix_script = pkgs.writeShellScriptBin "manix-search"
    (import ./bin/manix.nix { inherit pkgs; });
  search_script = pkgs.writeShellScriptBin "search"
    (import ./bin/nix-search.nix { inherit pkgs; });
  custom_fetch =
    pkgs.writeShellScriptBin "gfetch" (import ./bin/gfetch.nix { });
  preview_script = pkgs.writeShellScriptBin "preview.sh"
    (import ./bin/preview.nix { inherit pkgs; });

in {

  home.username = "javacafe01";
  home.homeDirectory = "/home/javacafe01";

  home.file = {
    #    ".config/awesome".source = ../config/awesome;
    ".config/wezterm".source = ../config/wezterm;
    ".config/nvim/lua/custom/chadrc.lua".source = ../config/nvchad/rc.lua;
    ".config/nvim/lua/custom/init.lua".source = ../config/nvchad/init.lua;
  };

  home.sessionVariables = { EDITOR = "nvim"; };

  home.packages = with pkgs; [
    # Programs
    mpv
    playerctl
    zoom-us
    gimp
    arandr
    gnome3.nautilus
    gnome3.eog
    feh
    evince
    manix
    sqlite
    element-desktop
    pandoc
    glxinfo
    master.neovim-unwrapped

    # Bin Scripts
    giph_wrapper
    updoot_script
    panes_script
    screenshot_script
    custom_fetch
    manix_script
    search_script
    preview_script

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

    python39Packages.discordpy

    discord

    # Formatters
    (import ../derivations/lua-format.nix {
      inherit stdenv fetchFromGitHub pkgs;
    })
    black

  ];

  programs = {
    bat = {
      enable = true;
      config = {
        pager = "never";
        style = "plain";
        theme = "base16";
      };
    };

    /*
    discocss = {
      enable = true;
      discord = pkgs.discord;
      discordAlias = true;
      css = import ./programs/discord-css.nix { };
      };
      */

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
          # userChrome = import ./programs/firefox/userChrome-css.nix { };
          userContent = import ./programs/firefox/userContent-css.nix { };

          # Pretty pog, I can enable css without going into firefox.
          extraConfig = ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("full-screen-api.ignore-widgets", true);
          '';
        };

        chat = {
          id = 1;
          settings = { "general.smoothScroll" = true; };
          userChrome = import ./programs/firefox/userChrome-css.nix { };
          userContent = import ./programs/firefox/userContent-css.nix { };

          extraConfig = ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("full-screen-api.ignore-widgets", true);
          '';
        };
      };
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

    ncmpcpp = {
      enable = true;
      settings = import ./programs/ncmpcpp.nix;
    };

    ncspot = {
      enable = false;
      settings = {
        use_nerdfont = true;
        notify = false;
      };
    };

    rofi = {
      enable = true;
      theme = import ./programs/rofi-theme.nix { inherit config; };
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

          zstyle ':fzf-tab:complete:*:*' fzf-preview '${preview_script}/bin/preview.sh $realpath'
      '';

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        save = 50000;
      };

      plugins = with pkgs; [
        {
          name = "zsh-completions";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            rev = "32732916a0d0a25adcdb25c4906e0111681a81e2";
            sha256 = "1arj4f0d3k6cmz0h5bs8wl2p9i86s7if39d52ywf9b8rpq9bz0k8";
          };
        }
        {
          name = "fzf-tab";
          src = fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "89a33154707c09789177a893e5a8ebbb131d5d3d";
            sha256 = "1g8011ldrghbw5ibchsp0p93r31cwyx2r1z5xplksd779jw79wdx";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "6e0e950154a4c6983d9e077ed052298ad9126144";
            sha256 = "sha256-m+gKQXNRYTpraWDXVMTU6UPJFivcyhOw3dNofFR4cyU=";
          };
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

    playerctld.enable = true;
  };

  systemd.user.startServices = true;

  gtk = {
    enable = true;
    theme = let
      phocus = pkgs.stdenv.mkDerivation {
        name = "javacafe_phocus";
        src = builtins.fetchTarball {
          url =
            "https://github.com/javacafe01/phocus-gtk/archive/master.tar.gz";
          sha256 = "0r92v06w769blm8n8hspq82g18m9fahbq8v8cfnp029k81w8jlz9";
        };
        nativeBuildInputs = [ pkgs.sass ];
        installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];
      };
    in {
      package = phocus;
      name = "javacafe_phocus";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font.name = "Sarasa UI K 10";
  };

xdg.enable = true;
  xresources.extraConfig = import ./x/resources.nix { };
}
