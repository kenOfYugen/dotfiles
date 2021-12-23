{ stdenv, fetchFromGitHub, pkgs, ... }:

stdenv.mkDerivation rec {
  name = "lua-format";
  version = "7c27bab3b7cd4ab0bae0f8d52336a093b5da307b";
  src = fetchFromGitHub {
    owner = "Koihik";
    repo = "LuaFormatter";
    rev = "${version}";
    sha256 = "sha256-seHh8uRvHcb06BqfXE1cdA8IhErbcH7udcBmz9jIbUs=";
    fetchSubmodules = true;
  };
  nativeBuildInputs = [ pkgs.cmake ];
}
