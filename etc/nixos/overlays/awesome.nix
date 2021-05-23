final: prev: {
  awesome = (prev.awesome.overrideAttrs (old: rec {
    src = prev.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "9c5149d4e3da34fd60ee57c99c2739af070c6344";
      sha256 = "1kj2qz2ns0jn5gha4ryr8w8vvy23s3bb5z3vjhwwfnrv7ypb40iz";
    };
    GI_TYPELIB_PATH = "${prev.playerctl}/lib/girepository-1.0:"
      + "${prev.upower}/lib/girepository-1.0:" + old.GI_TYPELIB_PATH;
  })).override {
    stdenv = prev.clangStdenv;
    luaPackages = prev.lua52Packages;
    gtk3Support = true;
  };
}
