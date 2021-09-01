{ stdenv, fetchurl, pkgs, ... }:

stdenv.mkDerivation rec {
  name = "sarasa-gothic-nerd";
  version = "1";

  src = fetchurl {
    url = "https://github.com/laishulu/Sarasa-Mono-SC-Nerd/archive/master.zip";
    sha256 = "sha256-BdCoxAdNdqKWunShHYAH41f6bh5nmj/+5oMZuMWFfV0=";
  };

  nativeBuildInputs = [ pkgs.unzip ];

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r *.ttf $out/share/fonts
  '';
}
