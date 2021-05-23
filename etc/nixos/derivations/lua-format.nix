{ stdenv, fetchFromGitHub, pkgs, ... }:

stdenv.mkDerivation rec {
  name = "lua-format";
  version = "417d4570a4265109ebbab6610023e91c4668f631";
  src = fetchFromGitHub {
    owner = "Koihik";
    repo = "LuaFormatter";
    rev = "${version}";
    sha256 = "163190g37r6npg5k5mhdwckdhv9nwy2gnfp5jjk8p0s6cyvydqjw";
    fetchSubmodules = true;
  };
  nativeBuildInputs = [ pkgs.cmake ];
}
