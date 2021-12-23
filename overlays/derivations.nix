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

  themer-lua-nvim = prev.callPackage ../derivations/themer-lua.nix {
    src = prev.themer-lua-nvim-src;
  };

  galaxyline-nvim = prev.callPackage ../derivations/galaxyline-nvim.nix {
    src = prev.galaxyline-nvim-src;
  };

  sworkstyle = prev.callPackage ../derivations/sworkstyle.nix {
    # inherit (prev.rustPlatform);
    src = prev.sworkstyle-src;
  };
}
