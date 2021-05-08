{ config, home, inputs, nixpkgs, user-overlays, ... }:

nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";

  modules = [
    {
      nixpkgs =
        let
          input-overlays = _: _: {
            comma = import inputs.comma { pkgs = nixpkgs.legacyPackages."${system}"; };
          };

          nixpkgs-overlays = _: _: with inputs; {
            master = import master { inherit config system; };
            unstable = import unstable { inherit config system; };
            stable = import stable { inherit config system; };
            staging = import staging { inherit config system; };
            staging-next = import staging-next { inherit config system; };

          };
        in
        {
          inherit config;

          overlays = with inputs; [
            nixpkgs-overlays
            emacs.overlay
            neovim-nightly.overlay
            nur.overlay
            rust.overlay
            input-overlays
          ] ++ user-overlays;
        };
    }

   ./configuration.nix

    home.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.javacafe01 = import ../javacafe01;
      };
    }

    nixpkgs.nixosModules.notDetected
  ];

  specialArgs = { inherit inputs; };
}
