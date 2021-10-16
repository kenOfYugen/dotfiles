{
  description = "JavaCafe's NixOS configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    discocss.url = "github:mlvzk/discocss/flake";
    home.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";

    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/nixos-21.05";
    staging.url = "github:nixos/nixpkgs/staging";
    staging-next.url = "github:nixos/nixpkgs/staging-next";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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
            in {
              # Packages provided by flake inputs
              discocss = discocss.defaultPackage.${system};
            } // (with nixpkgs-f2k.packages.${system}; {
              awesome = awesome-git;
              picom = picom-git;
              xdg-desktop-portal-wlr = xdg-desktop-portal-wlr-git;
            }) // {
              /* Nixpkgs branches
                 One can access these branches like so:
                 `pkgs.stable.mpd'
                 `pkgs.master.linuxPackages_xanmod'
              */
              master = import master { inherit config system; };
              unstable = import unstable { inherit config system; };
              stable = import stable { inherit config system; };
            })
          nur.overlay
          nixpkgs-f2k.overlay
        ]
        # Overlays from ./overlays directory
        ++ (importNixFiles ./overlays);
    in {
      nixosConfigurations.thonkpad = import ./thonkpad {
        inherit config home inputs nixpkgs overlays discocss;
        modules = [ nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme ];
      };

      thonkpad = self.nixosConfigurations.thonkpad.config.system.build.toplevel;
    };
}
