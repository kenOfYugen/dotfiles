{ pkgs, src }:

pkgs.vimUtils.buildVimPlugin rec {
  pname = "galaxyline-nvim";
  version = "0.1";
  inherit src;
}
