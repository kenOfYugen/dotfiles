{ lib
, buildLuarocksPackage
, luajit
, src
, argparse
, luafilesystem
, busted
, compat53
}:

buildLuarocksPackage {
  pname = "tl";
  version = "dev-1";

  inherit src;

  propagatedBuildInputs = [ luajit argparse luafilesystem busted compat53 ];

  meta = {
    homepage = "https://github.com/teal-language/tl";
    description = "Teal, a typed dialect of Lua";
    license.fullName = "MIT";
  };
}
