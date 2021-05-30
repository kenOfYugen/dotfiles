{ stdenv, fetchFromGitHub, pkgs, ... }:

stdenv.mkDerivation rec {
  name = "lua-format";
  version = "42fea5f7a3f8b1bd5d59c191ef50a3b87f3fc8f5";
  src = fetchFromGitHub {
    owner = "Koihik";
    repo = "LuaFormatter";
    rev = "${version}";
    sha256 = "163190g37r6npg5k5mhdwckdhv9nwy2gnfp5jjk8p0s6cyvydqjw";
    fetchSubmodules = true;
  };
  nativeBuildInputs = [ pkgs.cmake ];
}
