(self: super: {
  st = super.st.overrideAttrs (oldAttrs: {
    pname = "st";
    version = "1.0.0";
    src = super.fetchFromGitHub {
      owner = "siduck76";
      repo = "st";
      rev = "c9bda1de1f3f94ba507fa0eacc96d6a4f338637f";
      sha256 = "10771ni4axgbxkfaa5bh6zgya42sxss9fvd7xlp1k1jm568r0zz6";
    };
    buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
  });
})
