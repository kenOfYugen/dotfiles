{
  description = "JavaCafe's NixOS configuration";

  inputs = {
    discocss.url = "github:mlvzk/discocss/flake";
    home.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/nixos-21.11";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland?rev=3716a3aea917103d20330c13cd40b956f8e51078";
    nixvim.url = "github:pta2002/nixvim";

    eww.url = "github:elkowar/eww";

    emacs.url = "github:nix-community/emacs-overlay";

    # Non Flakes
    phocus = { url = "github:JavaCafe01/gtk"; flake = false; };
    addy-bitmap-fonts = { url = "github:addy-dclxvi/bitmap-font-collections"; flake = false; };
    zsh-completions = { url = "github:zsh-users/zsh-completions"; flake = false; };
    zsh-syntax-highlighting = { url = "github:zsh-users/zsh-syntax-highlighting"; flake = false; };
    fzf-tab = { url = "github:Aloxaf/fzf-tab"; flake = false; };
    teal = { url = "github:teal-language/tl"; flake = false; };
    unclutter-xfixes-nowrep = { url = "github:nowrep/unclutter-xfixes"; flake = false; };
    themer-lua-nvim = { url = "github:JavaCafe01/themer.lua/dev"; flake = false; };
    galaxyline-nvim = { url = "github:NTBBloodbath/galaxyline.nvim"; flake = false; };
    sworkstyle = { url = "github:Lyr-7D1h/swayest_workstyle"; flake = false; };

    nixpkgs.follows = "unstable";
  };

  outputs =
    { self, home, nixpkgs, discocss, nixpkgs-f2k, nixpkgs-wayland, nixvim, ... }@inputs:
      with nixpkgs.lib;
      let
        config = {
          allowBroken = true;
          allowUnfree = true;
          tarball-ttl = 0;
        };

        filterNixFiles = k: v: v == "regular" && hasSuffix ".nix" k;

        importNixFiles = path:
          (lists.forEach (mapAttrsToList (name: _: path + ("/" + name))
            (filterAttrs filterNixFiles (builtins.readDir path)))) import;

        overlays = with inputs;
          [
            (final: _:
              let system = final.system;
              in
              {
                # Packages provided by flake inputs
                eww-way = eww.packages.${system}.eww-wayland;
                discocss = discocss.defaultPackage.${system};
                neovim-nightly = neovim.packages.${system}.neovim;
                nixvim = nixvim.defaultPackage.${system};
              } // (with nixpkgs-f2k.packages.${system}; {
                # Overlays with f2k's repo
                awesome = awesome-git;
                picom = picom-git;
                river = river-git;
                kile-wl = kile-wl-git;
              }) // (with nixpkgs-wayland.packages.${system}; {
                # Wayland Stuff
                # foot = foot;
                mako = mako;
                slurp = slurp;
                swaybg = swaybg;
                swayidle = swayidle;
                swaylock = swaylock;
                sway-git = sway-unwrapped;
                waybar = waybar;
                wayfire = wayfire;
                wdisplays = wdisplays;
                wf-recorder = wf-recorder;
                wlroots = wlroots;
                wl-clipboard = wl-clipboard;
                wtype = wtype;
                xdg-desktop-portal-wlr = xdg-desktop-portal-wlr;
              }) // {
                # Non Flakes
                phocus-src = phocus;
                addy-bitmap-fonts-src = addy-bitmap-fonts;
                zsh-completions-src = zsh-completions;
                zsh-syntax-highlighting-src = zsh-syntax-highlighting;
                fzf-tab-src = fzf-tab;
                teal-src = teal;
                unclutter-xfixes-nowrep-src = unclutter-xfixes-nowrep;
                themer-lua-nvim-src = themer-lua-nvim;
                galaxyline-nvim-src = galaxyline-nvim;
                sworkstyle-src = sworkstyle;

                /* Nixpkgs branches
                  One can access these branches like so:
                  `pkgs.stable.mpd'
                  `pkgs.master.linuxPackages_xanmod'
                */
                master = import master { inherit config system; };
                unstable = import unstable { inherit config system; };
                stable = import stable { inherit config system; };
              })
            neovim-nightly-overlay.overlay
            nur.overlay
            nixpkgs-f2k.overlay
            nixpkgs-wayland.overlay
            emacs.overlay
          ]
          # Overlays from ./overlays directory
          ++ (importNixFiles ./overlays);
      in
      {
        nixosConfigurations.thonkpad = import ./thonkpad {
          inherit config home inputs nixpkgs overlays discocss nixvim;
        };

        thonkpad = self.nixosConfigurations.thonkpad.config.system.build.toplevel;
      };
}
