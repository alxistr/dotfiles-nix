{ fetchzip, autoPatchelfHook, stdenv }:

stdenv.mkDerivation rec {
  name = "ventoy";
  version = "1.0.40";

  src = fetchzip {
    url = "https://github.com/ventoy/Ventoy/releases/download/v1.0.40/ventoy-${version}-linux.tar.gz";
    sha256 = "0r3999zpdpiwndi42hryiccdyfqh410ky06f9nfs603gpbibsibr";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  propagatedBuildInputs = [ ];

  buildPhase = ''
    for file in $(ls tool/**/*.xz); do
      xzcat $file > ''${file%.xz}
      [ -f ./''${file%.xz} ] && chmod +x ./''${file%.xz}
      [ -f ./$file ] && rm -f ./$file
    done
  '';

  installPhase = ''
    mkdir -p $out/
    cp -a . $out/
  '';

}
