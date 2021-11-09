final: prev: {
  phocus = prev.callPackage ../derivations/phocus.nix {
    src = prev.phocus-src;
    theme = import ../theme/theme.nix { };
  };

  bitmap-font-collections = prev.callPackage ../derivations/addy-bitmap-fonts.nix {
    src = prev.addy-bitmap-fonts-src;
  };

  teal-lang = prev.callPackage ../derivations/teal.nix {
    inherit (prev.luajitPackages) buildLuarocksPackage argparse luafilesystem busted compat53;
    src = prev.teal-src;
  };
}
