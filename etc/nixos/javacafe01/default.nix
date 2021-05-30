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

  home.sessionVariables = { EDITOR = "emacs"; };

  home.packages = with pkgs; [
    mpv
    playerctl
    zoom-us
    gimp
    arandr
    gnome3.nautilus
    gnome3.eog
    evince
    giph_wrapper
    updoot_script
    panes_script
    screenshot_script
    custom_fetch
    manix
    manix_script
    sqlite
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

    # Formatters
    (import ../derivations/lua-format.nix {
      inherit stdenv fetchFromGitHub pkgs;
    })
    black

    # Matrix Client
    element-desktop

    pandoc
    tdesktop
    glxinfo
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

    discocss = {
      enable = true;
      discord = pkgs.master.discord;
      discordAlias = true;
      css = import ./programs/discord-css.nix { };
    };

    emacs = {
      enable = true;
      package = pkgs.emacsPgtkGcc;
      extraPackages = (epkgs: [ epkgs.vterm ]);
    };

    exa = {
      enable = true;
      enableAliases = false;
    };

    firefox = {
      enable = true;

      profiles = {
        myprofile = {
          id = 0;
          settings = { "general.smoothScroll" = true; };
          userChrome = builtins.readFile (builtins.fetchurl {
            url =
              "https://raw.githubusercontent.com/JavaCafe01/firefox-css/master/userChrome.css";
            sha256 = "1v15ic3w9g2n6gzrpxwrr6qdz4gq7r3p2v96qiwjs1sm4jv1gmlc";
          });
          userContent = builtins.readFile (builtins.fetchurl {
            url =
              "https://raw.githubusercontent.com/JavaCafe01/firefox-css/master/userContent.css";
            sha256 = "0r8sx50xv567fbq4v31rh5rhz4m4wabrxc34a18842bkjyq2cw9i";
          });
        };

        chat = {
          id = 1;
          settings = { "general.smoothScroll" = true; };
          userChrome = builtins.readFile (builtins.fetchurl {
            url =
              "https://raw.githubusercontent.com/JavaCafe01/firefox-css/master/userChrome.css";
            sha256 = "1v15ic3w9g2n6gzrpxwrr6qdz4gq7r3p2v96qiwjs1sm4jv1gmlc";
          });
          userContent = builtins.readFile (builtins.fetchurl {
            url =
              "https://raw.githubusercontent.com/JavaCafe01/firefox-css/master/userContent.css";
            sha256 = "0r8sx50xv567fbq4v31rh5rhz4m4wabrxc34a18842bkjyq2cw9i";
          });
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

    rofi = { enable = true; };

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
      };

      initExtra = ''
        set -k
        setopt auto_cd
        export PATH="''${HOME}/.local/bin:''${HOME}/go/bin:''${HOME}/.emacs.d/bin/:''${HOME}/.npm/bin/:''${PATH}"
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
          name = "zsh-syntax-highlighting";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.8.0-alpha1-pre-redrawhook";
            sha256 = "1gv7cl4kyqyjgyn3i6dx9jr5qsvr7dx1vckwv5xg97h81hg884rn";
          };
          file = "zsh-syntax-highlighting.zsh";
        }
        {
          name = "zsh-completions";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            rev = "0.33.0";
            sha256 = "1c2xx9bkkvyy0c6aq9vv3fjw7snlm0m5bjygfk5391qgjpvchd29";
          };
        }
        {
          name = "fzf-tab";
          src = fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "3d6aca79b68b8b98286dda2cb76076f2a2081225";
            sha256 = "0kr6f3ii0gl61fhhd2nybwpcsjv816ag98xbjgz82ihlay4nqi6k";
          };
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

    picom = {
      package = (pkgs.picom.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "yshui";
          repo = "picom";
          rev = "7ba87598c177092a775d5e8e4393cb68518edaac";
          sha256 = "0za3ywdn27dzp7140cpg1imbqpbflpzgarr76xaqmijz97rv1909";
        };
      })).override { stdenv = pkgs.clangStdenv; };

      enable = true;
      experimentalBackends = true;
      backend = "glx";
      vSync = true;
      shadow = true;
      shadowOffsets = [ (-18) (-18) ];

      shadowExclude = [
        "window_type *= 'menu'"
        "window_type = 'popup_menu'"
        "window_type = 'notification'"
        "class_g = 'slop'"
        "window_type = 'dropdown_menu'"
        "window_type = 'menu'"
        "class_g = 'Firefox' && window_type *= 'utility'"
        "_GTK_FRAME_EXTENTS@:c"
        "_NET_WM_WINDOW_TYPE:a = '_NET_WM_WINDOW_TYPE_NOTIFICATION'"
      ];

      extraOptions = ''
        shadow-ignore-shaped = false;
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-client-opacity = true;
        detect-transient = true;
        detect-client-leader = true;
        resize-damage = 1;
        glx-no-stencil = true;
        use-damage = true;
      '';

    };

    playerctld.enable = true;
  };

  systemd.user.startServices = true;

  gtk = {
    enable = true;
    theme = let
      phocus = pkgs.stdenv.mkDerivation {
        name = "elkowars_phocus";
        src = builtins.fetchTarball {
          url =
            "https://github.com/javacafe01/phocus-gtk/archive/master.tar.gz";
          sha256 = "1wbqblvdr1p3xalhia4l8yr9zbjvwyanhr1cnj9rhdjli4zn8wwh";
        };
        nativeBuildInputs = [ pkgs.sass ];
        installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];
      };
    in {
      package = phocus;
      name = "elkowars_phocus";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font.name = "Sarasa UI K 10";
  };

  xresources.extraConfig = import ./x/resources.nix { };
}
