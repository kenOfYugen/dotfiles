(self: super: {
  st = super.st.overrideAttrs (oldAttrs: {
    pname = "st";
    version = "1.0.0";
    src = super.fetchFromGitHub {
      owner = "JavaCafe01";
      repo = "st";
      rev = "8c673cffdc48a8107f4ea89eba77d0db63c9c329";
      sha256 = "1nhwsw1m4a34569ibpnbwff13x42w447lbkhgmc2hqk1d2v7h0xf";
    };
    buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
  });
})
