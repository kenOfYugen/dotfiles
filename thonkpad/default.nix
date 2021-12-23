{ config, home, inputs, nixpkgs, overlays, discocss, nixvim, ... }:

nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";

  modules = [
    home.nixosModules.home-manager
    nixpkgs.nixosModules.notDetected

    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [ discocss.hmModule nixvim.homeManagerModules.nixvim ];
        users.javacafe01 = nixpkgs.lib.mkMerge [ ../javacafe01 ];
      };

      nixpkgs = { inherit config overlays; };
    }

    ./configuration.nix
  ];

  specialArgs = { inherit inputs; };
}
