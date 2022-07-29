{ pkgs, stdenv, writeScriptBin, rlwrap, clpkg ? pkgs.ecl }:

let
  clname = clpkg.pname;
  shen = stdenv.mkDerivation rec {
    name = "shen-${clname}";
    version = "3.0.3";
    src = builtins.fetchurl "https://github.com/Shen-Language/shen-cl/releases/download/v${version}/shen-cl-v${version}-sources.tar.gz";
    buildInputs = [ clpkg ];
    buildPhase = ''
      make build-${clname}
      mkdir -p $out/bin
      cp -r bin/${clname}/shen $out/bin/shen-${clname}
    '';
    installPhase = ":";
  };
in

writeScriptBin "shen"
 ''
   ${rlwrap}/bin/rlwrap ${shen}/bin/shen-${clname} $@
 ''
