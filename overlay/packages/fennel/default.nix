{ fetchurl, stdenv, lua, luaPackages,
  fetchFromGitHub, makeWrapper, inotify-tools }:

with stdenv.lib;

let src = fetchFromGitHub {
  owner = "bakpakin";
  repo = "Fennel";
  rev = "324a4a8bdc3ecfff40dd677ccc707ab1750a7a16";
  sha256 = "1yn2lyfcrsjcx60lxy0xcyl2rfk4r5pydbkcblpikpk6vhr10ws0";
}; in

let
  buildLuaPackage = { src, name }: (luaPackages.buildLuaPackage {
    inherit name src;
    buildInputs = [ lua ];
    disabled = (luaPackages.luaOlder "5.1");
    buildPhase = ":";
    installPhase = ''
      mkdir -p "$out/lib/lua/${lua.luaversion}/"
      find $src -name "*.lua" -exec cp {} "$out/lib/lua/${lua.luaversion}/" \;
    '';
  });
  libs = [
    (buildLuaPackage {
      name = "fennel";
      inherit src;
    })
    (buildLuaPackage {
      name = "inspect";
      src = fetchFromGitHub {
        owner = "kikito";
        repo = "inspect.lua";
        rev = "7fc6126e32854552843af7e26b218581db1f1b0f";
        sha256 = "1407vlc5kwz6s3002nxn03kpbji20whfflbc5v5njf0p4sz9avw2";
      };
    })
  ];
  getPath = lib : type : "${lib}/lib/lua/${lua.luaversion}/?.${type};${lib}/share/lua/${lua.luaversion}/?.${type}";
  getLuaPath = lib : getPath lib "lua";
  getLuaCPath = lib : getPath lib "so";
  luaPath = concatStringsSep ";" (map getLuaPath  libs);
  luaCPath = concatStringsSep ";" (map getLuaCPath libs);
in

stdenv.mkDerivation {
  name = "fennel";
  inherit src;

  buildInputs = [ lua makeWrapper ];

  buildPhase = ":";

  installPhase = let
    binPath = stdenv.lib.makeBinPath [ inotify-tools ];
  in ''
    # mkdir -p $prefix/libexec
    # cp clojure-tools-${version}.jar $prefix/libexec
    # cp {,example-}deps.edn $prefix
    # substituteInPlace clojure --replace PREFIX $prefix

    install -Dt $out/bin fennel fennel-watch.sh

    wrapProgram $out/bin/fennel \
      --set LUA_PATH '${luaPath};' \
      --set LUA_CPATH '${luaCPath};'
    wrapProgram $out/bin/fennel-watch.sh \
      --set LUA_PATH '${luaPath};' \
      --set LUA_CPATH '${luaCPath};' \
      --prefix PATH : $out/bin:${binPath}
  '';

}
