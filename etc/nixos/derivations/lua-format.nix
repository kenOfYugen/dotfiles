{ stdenv, fetchFromGitHub, pkgs, ... }:

stdenv.mkDerivation rec {
  name = "lua-format";
  version = "5ab5de2eab4af5241fbb2beb9eee69d039d25263";
  src = fetchFromGitHub {
    owner = "Koihik";
    repo = "LuaFormatter";
    rev = "${version}";
    sha256 = "sha256-m+gKQXNRYTpraWDXVMTU6UPJFivcyhOw3dNofFR4cyU=";
    fetchSubmodules = true;
  };
  nativeBuildInputs = [ pkgs.cmake ];
}
