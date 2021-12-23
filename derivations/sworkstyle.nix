{ lib
, src
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "sworkstyle";
  version = "master";

  inherit src;

  cargoSha256 = "sha256-19PqyMEZfwZuShExo1QOKfBx8CCc7Jle0hOC8+mgB3k=";

  meta = with lib; {
    description = "Map workspace name to icons defined depending on the windows inside of the workspace, similar to workstyle.";
    homepage = "https://github.com/Lyr-7D1h/swayest_workstyle";
    license = licenses.mit;
    maintainers = [ maintainers.javacafe01 ];
  };
}
