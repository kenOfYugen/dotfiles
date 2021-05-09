{ config, pkgs, ... }:

let 
  giph_wrapper = pkgs.writeShellScriptBin "jeff" (import ./bin/jeff.nix {inherit pkgs;});
  screenshot_script = pkgs.writeShellScriptBin "shoot" (import ./bin/shoot.nix {inherit pkgs;});
  panes_script = pkgs.writeShellScriptBin "panes" (import ./bin/panes.nix {});
  updoot_script = pkgs.writeShellScriptBin "updoot" (import ./bin/updoot.nix {inherit pkgs;});

  extensions = (with pkgs.vscode-extensions; [
    bbenoist.Nix
    ms-python.python
  ]);
  vscode-with-extensions = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
  };
in
  {
    home.packages = with pkgs; [
      playerctl
      zoom-us
      gimp
      arandr
      gnome3.nautilus
      gnome3.eog
      giph_wrapper
      updoot_script
      panes_script
      screenshot_script
      vscode-with-extensions
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
      # Set to false if you don't want your Discord binary to be aliased to discocss
      discordAlias = true;
      css = import ./programs/discord-css.nix {};
    };

    emacs = {
      enable = true;
      # package = pkgs.emacsPgtkGcc;
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    firefox = {
      enable = true;
      profiles = {
        myprofile = {
          settings = {
            "general.smoothScroll" = true;
          };
          userChrome = builtins.readFile (builtins.fetchurl { 
            url = "https://raw.githubusercontent.com/JavaCafe01/firefox-css/master/userChrome.css"; 
            sha256 = "1v15ic3w9g2n6gzrpxwrr6qdz4gq7r3p2v96qiwjs1sm4jv1gmlc";
          });
          userContent = builtins.readFile (builtins.fetchurl { 
            url = "https://raw.githubusercontent.com/JavaCafe01/firefox-css/master/userContent.css";
            sha256 = "1mlkmz2fm0d2glz85ycc3dlf2vk30dj2vwnbnhw3c470y56wblxr";
          });
        };
      };
    };

    git = {
      enable = true;
      userName  = "Gokul Swaminathan";
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

    rofi = {
      enable = true;
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
          url = "https://github.com/javacafe01/phocus-gtk/archive/master.tar.gz";
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
    font = { name = "Sarasa UI K 10"; };
  };


  xresources.extraConfig = import ./x/resources.nix {};
}
