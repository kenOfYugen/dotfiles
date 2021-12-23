final: prev: {
  unclutter-xfixes = prev.unclutter-xfixes.overrideAttrs (old: {
    src = prev.unclutter-xfixes-nowrep-src;
  });
}
