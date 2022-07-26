{ pkgs, stdenv, lib, git, makeWrapper, clpkg ? pkgs.ecl }:

let clname = clpkg.pname; in

stdenv.mkDerivation rec {
  name = "shen-ecl";
  version = "3.0.3";
  src = builtins.fetchurl "https://github.com/Shen-Language/shen-cl/releases/download/v${version}/shen-cl-v${version}-sources.tar.gz";

  buildInputs = [ makeWrapper clpkg ];

  buildPhase = ''
    make build-${clname}
    mkdir -p $out/bin
    cp -r bin/${clname}/shen $out/bin/shen
  '';

  installPhase = ":";

}
