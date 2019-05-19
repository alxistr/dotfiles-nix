{ lua, luaPackages, fetchFromGitHub }:
luaPackages.buildLuaPackage {
  name = "awesome-freedesktop";
  src = fetchFromGitHub {
    owner = "lcpz";
    repo = "awesome-freedesktop";
    rev = "6951b09b9813a8c98c9927d8b1f78b710b8c993c";
    sha256 = "0x7d0hsggbk92y89mpzp4n5ap8fsa2rkfv43nlcy0fhjv0ix2fdr";
  };
  buildPhase = ":";
  installPhase = ''
    mkdir -p "$out/lib/lua/${lua.luaversion}/freedesktop/"
    find $src -name "*.lua" -exec cp {} "$out/lib/lua/${lua.luaversion}/freedesktop/" \;
  '';
}
