{ pkgs, src }:

pkgs.vimUtils.buildVimPlugin rec {
  pname = "themer-lua-nvim";
  version = "0.1";
  inherit src;
}
