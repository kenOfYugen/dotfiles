{ stdenv, pkgs, src }:

stdenv.mkDerivation rec {
  name = "material-round-icons";
  version = "1";

  inherit src;

  nativeBuildInputs = [ pkgs.unzip ];

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r *.otf $out/share/fonts
  '';
}
