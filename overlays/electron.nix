self:
let
  enableWayland = drv: bin: drv.overrideAttrs (
    old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ self.makeWrapper ];
      postFixup = (old.postFixup or "") + ''
        wrapProgram $out/bin/${bin} \
          --add-flags "--enable-features=UseOzonePlatform" \
          --add-flags "--ozone-platform=wayland"
      '';
    }
  );
in
super:
{
  discord = enableWayland super.discord "discord";
  google-chrome = (
    super.google-chrome.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
    }
  );
}
