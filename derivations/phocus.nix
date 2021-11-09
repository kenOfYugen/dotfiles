{ lib, stdenvNoCC, fetchFromGitHub, sass, src, theme }:

with theme.colors;

stdenvNoCC.mkDerivation rec {
  pname = "phocus";
  version = "unstable-2021-11-01";

  inherit src;

  prePatch = ''
    substituteInPlace scss/gtk-3.0/_colors.scss \
      --replace 16161c ${bg} \
      --replace 232530 ${c0} \
      --replace 2e303e ${c8} \
      --replace 2e303f ${dbg} \
      --replace e95678 ${c1} \
      --replace f09383 ${c2} \
      --replace fab795 ${c3} \
      --replace 29d398 ${c4} \
      --replace 1eb980 ${c5} \
      --replace 26bbd9 ${c6} \
      --replace ee64ae ${c6} \
      --replace ec6a88 ${c14} \
      --replace aabbcc ${c4} \
      --replace ccbbaa ${c6}
  '';

  nativeBuildInputs = [ sass ];

  installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];

  meta = with lib; {
    description = "phocus gtk with javacafe's color scheme";
    homepage = "https://github.com/JavaCafe01/gtk";
    license = [ licenses.mit ];
    maintainers = with maintainers; [ JavaCafe01 ];
  };
}
