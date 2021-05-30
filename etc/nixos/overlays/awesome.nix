final: prev: {
  awesome = (prev.awesome.overrideAttrs (old: rec {
    src = prev.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "b65025ef62612eec2d0a17eff9b641e516476e16";
      sha256 = "0wa9lw7fv2n91b6d9i1d492zlkdk6jxxz277g3g4vrvwwgg76d7s";
    };
    GI_TYPELIB_PATH = "${prev.playerctl}/lib/girepository-1.0:"
      + "${prev.upower}/lib/girepository-1.0:" + old.GI_TYPELIB_PATH;
  })).override {
    stdenv = prev.clangStdenv;
    luaPackages = prev.lua52Packages;
    gtk3Support = true;
  };
}
