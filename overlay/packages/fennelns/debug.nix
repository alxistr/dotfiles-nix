{ pkgs, stdenv, lib, fennelns }:

let
  files = [
    ./tests/without-ns.fnl
    ./tests/empty-ns.fnl
    ./tests/lua-export.fnl
    ./tests/empty-macros.fnl
  ];
in

stdenv.mkDerivation rec {
  name = "fennelns-debug";

  buildInputs = with pkgs; [
    fennelns
  ];

  shellHook = lib.concatStrings (map (file: ''
    echo "--------------------------------"
    echo "${file}"
    fnlnsf ${file}
  '') files) + ''
    echo "--------------------------------"
    echo "done"
    exit
  '';

}

