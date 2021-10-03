{ config, home, inputs, nixpkgs, user-overlays, discocss, ... }:

nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";

  modules = [
    {
      nixpkgs = let
        input-overlays = _: _: {
          comma =
            import inputs.comma { pkgs = nixpkgs.legacyPackages."${system}"; };
        };

        nixpkgs-overlays = _: _:
          with inputs; {
            master = import master { inherit config system; };
            unstable = import unstable { inherit config system; };
            stable = import stable { inherit config system; };
            staging = import staging { inherit config system; };
            staging-next = import staging-next { inherit config system; };
          };
      in {
        inherit config;

        overlays = with inputs;
          [
            nixpkgs-overlays
            nur.overlay
            input-overlays
            nixpkgs-f2k.overlay
          ] ++ user-overlays;
      };
    }

    ./configuration.nix

    home.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [ discocss.hmModule ];
        users.javacafe01 = nixpkgs.lib.mkMerge [ ../javacafe01 ];
      };
    }

    nixpkgs.nixosModules.notDetected
  ];

  specialArgs = { inherit inputs; };
}
