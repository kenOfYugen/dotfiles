{ stdenv, pkgs, src }:

stdenv.mkDerivation rec {
  name = "bitmap-font-collections";
  version = "1";

  inherit src;

  nativeBuildInputs = [ pkgs.unzip ];

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r *.bdf $out/share/fonts
  '';
}
