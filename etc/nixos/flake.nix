{
  description = "A somewhat huge NixOS configuration using Nix Flakes.";

  inputs = {
    nixos-hardware.url = github:NixOS/nixos-hardware/master;

    comma = {
      url = "github:Shopify/comma";
      flake = false;
    };

    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs.url = "github:nix-community/emacs-overlay";
    nur.url = "github:nix-community/NUR";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    rust.url = "github:oxalica/rust-overlay";

    # nixpkgs branches
    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/release-20.09";
    staging.url = "github:nixos/nixpkgs/staging";
    staging-next.url = "github:nixos/nixpkgs/staging-next";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # default nixpkgs for packages and modules
    nixpkgs.follows = "unstable";
  };

  outputs = { self, home, nixpkgs, nixos-hardware, ... } @ inputs:
    with nixpkgs.lib;
    let
      config = {
        allowBroken = true;
        allowUnfree = true;
      };

      filterNixFiles = k: v: v == "regular" && hasSuffix ".nix" k;

      importNixFiles = path: (lists.forEach (mapAttrsToList (name: _: path + ("/" + name))
        (filterAttrs filterNixFiles (builtins.readDir path)))) import;

      user-overlays = importNixFiles ./overlays;
    in
    {
      nixosConfigurations.thonkpad = import ./thonkpad {
        inherit config home inputs nixpkgs user-overlays;
	modules = [
	  nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme
	];
      };

      thonkpad = self.nixosConfigurations.thonkpad.config.system.build.toplevel;
    };
}
