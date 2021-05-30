{
  description = "JavaCafe's NixOS configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    discocss.url = "github:mlvzk/discocss/flake";
    home.url = "github:nix-community/home-manager";
    emacs.url = "github:mjlbach/emacs-overlay";
    nur.url = "github:nix-community/NUR";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/release-20.09";
    staging.url = "github:nixos/nixpkgs/staging";
    staging-next.url = "github:nixos/nixpkgs/staging-next";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixpkgs.follows = "unstable";
  };

  outputs = { self, home, nixpkgs, nixos-hardware, discocss, ... }@inputs:
    with nixpkgs.lib;
    let
      config = {
        allowBroken = true;
        allowUnfree = true;
      };

      filterNixFiles = k: v: v == "regular" && hasSuffix ".nix" k;

      importNixFiles = path:
        (lists.forEach (mapAttrsToList (name: _: path + ("/" + name))
          (filterAttrs filterNixFiles (builtins.readDir path)))) import;

      user-overlays = importNixFiles ./overlays;
    in {
      nixosConfigurations.thonkpad = import ./thonkpad {
        inherit config home inputs nixpkgs user-overlays discocss;
        modules = [ nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme ];
      };

      thonkpad = self.nixosConfigurations.thonkpad.config.system.build.toplevel;
    };
}
