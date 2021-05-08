final: prev: {
  picom = (prev.picom.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "yshui";
      repo = "picom";
      rev = "7ba87598c177092a775d5e8e4393cb68518edaac";
      sha256 = "sha256-CaSw80lfxopVNydn9f6lbl28agzvMkDCub8dYRv3Q30=";
    };
  })).override { stdenv = prev.clangStdenv; };
}
