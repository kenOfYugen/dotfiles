{
  description = "JavaCafe's NixOS configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    discocss.url = "github:mlvzk/discocss/flake";
    home.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";

    emacs.url = "github:nix-community/emacs-overlay";
    eww.url = "github:elkowar/eww";

    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/nixos-21.05";
    staging.url = "github:nixos/nixpkgs/staging";
    staging-next.url = "github:nixos/nixpkgs/staging-next";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Non Flakes
    phocus = { url = "github:JavaCafe01/gtk"; flake = false; };
    addy-bitmap-fonts = { url = "github:addy-dclxvi/bitmap-font-collections"; flake = false; };
    zsh-completions = { url = "github:zsh-users/zsh-completions"; flake = false; };
    zsh-syntax-highlighting = { url = "github:zsh-users/zsh-syntax-highlighting"; flake = false; };
    fzf-tab = { url = "github:Aloxaf/fzf-tab"; flake = false; };
    teal = { url = "github:teal-language/tl"; flake = false; };

    nixpkgs.follows = "unstable";
  };

  outputs =
    { self, home, nixpkgs, nixos-hardware, discocss, nixpkgs-f2k, ... }@inputs:
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
                eww = eww.defaultPackage.${system};
                discocss = discocss.defaultPackage.${system};
              } // (with nixpkgs-f2k.packages.${system}; {
                # Overlays with f2k's repo
                awesome = awesome-git;
                picom = picom-git;
              }) // {
                # Non Flakes
                phocus-src = phocus;
                addy-bitmap-fonts-src = addy-bitmap-fonts;
                zsh-completions-src = zsh-completions;
                zsh-syntax-highlighting-src = zsh-syntax-highlighting;
                fzf-tab-src = fzf-tab;
                teal-src = teal;

                /* Nixpkgs branches
                  One can access these branches like so:
                  `pkgs.stable.mpd'
                  `pkgs.master.linuxPackages_xanmod'
                */
                master = import master { inherit config system; };
                unstable = import unstable { inherit config system; };
                stable = import stable { inherit config system; };
              })
            emacs.overlay
            nur.overlay
            nixpkgs-f2k.overlay
          ]
          # Overlays from ./overlays directory
          ++ (importNixFiles ./overlays);
      in
      {
        nixosConfigurations.thonkpad = import ./thonkpad {
          inherit config home inputs nixpkgs overlays discocss;
          modules = [ nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme ];
        };

        thonkpad = self.nixosConfigurations.thonkpad.config.system.build.toplevel;
      };
}
