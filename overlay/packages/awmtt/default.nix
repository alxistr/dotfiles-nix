{ pkgs, stdenv, lib, makeWrapper, fetchFromGitHub }:

let
  getLuaPath = lib : dir : "${lib}/${dir}/lua/${pkgs.luaPackages.lua.luaversion}";
  makeSearchPath = lib.concatMapStrings (path:
    " --search " + (getLuaPath path "share") +
    " --search " + (getLuaPath path "lib")
  );

  luaPackages = with pkgs; [
    awesome-freedesktop
    lua-moses
  ];

  binPath = lib.makeBinPath (with pkgs; [
    xorg.xorgserver
    (writeScriptBin "awesome"
      "${awesome}/bin/awesome ${makeSearchPath luaPackages} $@")
  ]);

in

stdenv.mkDerivation rec {
  name = "awmtt";

  src = fetchFromGitHub {
    owner = "serialoverflow";
    repo = "awmtt";
    rev = "92ababc7616bff1a7ac0a8e75e0d20a37c1e551e";
    sha256 = "1im03468ipyh3fbqln0wqmivsmgl944iqlii2xw8ndqxnaw452nw";
  };

  nativeBuildInputs = [ makeWrapper ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p $out/bin/
    cp $src/awmtt.sh $out/bin/awmtt
    chmod +x $out/bin/awmtt
    wrapProgram $out/bin/awmtt --prefix PATH : "${binPath}"
  '';

}
