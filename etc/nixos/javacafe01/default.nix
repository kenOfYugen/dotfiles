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

in {

  home.packages = with pkgs; [
    arduino
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
    manix
    manix_script
    sqlite
    search_script

    # Python Packages
    python38Packages.matplotlib
    python38Packages.scipy
    python38Packages.pyserial
    python38Packages.numpy
    python38Packages.black
    python38Packages.setuptools

    # Language servers
    sumneko-lua-language-server
    nodePackages.bash-language-server
    rust-analyzer
    rustfmt
    nodePackages.pyright
    nodePackages.vim-language-server
    ccls
    texlive.combined.scheme-medium
    rnix-lsp
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
          settings = { "general.smoothScroll" = true; };
          userChrome = builtins.readFile (builtins.fetchurl {
            url =
              "https://raw.githubusercontent.com/JavaCafe01/firefox-css/master/userChrome.css";
            sha256 = "1v15ic3w9g2n6gzrpxwrr6qdz4gq7r3p2v96qiwjs1sm4jv1gmlc";
          });
          userContent = builtins.readFile (builtins.fetchurl {
            url =
              "https://raw.githubusercontent.com/JavaCafe01/firefox-css/master/userContent.css";
            sha256 = "1mlkmz2fm0d2glz85ycc3dlf2vk30dj2vwnbnhw3c470y56wblxr";
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
            rev = "0.6.0";
            sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
          };
          file = "zsh-syntax-highlighting.zsh";
        }
        {
          name = "zsh-completions";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            rev = "0.27.0";
            sha256 = "1c2xx9bkkvyy0c6aq9vv3fjw7snlm0m5bjygfk5391qgjpvchd29";
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
