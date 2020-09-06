{ pkgs, lua, luaPackages, fetchFromGitHub }:
luaPackages.buildLuaPackage {
  name = "lua-moses";
  src = fetchFromGitHub {
    owner = "Yonaba";
    repo = "Moses";
    rev = "14171d243b76c845c3a9001aee1a0e9d2056f95e";
    sha256 = "1j4g5wc9xxqrgllz6iszvzw4qpzs879304s77l5gnb4ryv7s176s";
  };
  buildPhase = ":";
  installPhase = ''
    mkdir -p "$out/lib/lua/${lua.luaversion}/"
    find $src -name "*.lua" -exec cp {} "$out/lib/lua/${lua.luaversion}/" \;
    # ${pkgs.tree}/bin/tree $out
  '';
}
