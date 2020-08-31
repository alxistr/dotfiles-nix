# https://github.com/eraserhd/parinfer-rust/blob/master/derivation.nix

{ stdenv, rustPlatform, fetchFromGitHub, llvmPackages }:

rustPlatform.buildRustPackage rec {
  name = "parinfer-rust-${version}";
  version = "0.4.3";

  src = fetchFromGitHub {
    owner = "eraserhd";
    repo = "parinfer-rust";
    rev = "7b67f166e8ad12899903a0ea451333c41ed80544";
    sha256 = "0hj5in5h7pj72m4ag80ing513fh65q8xlsf341qzm3vmxm3y3jgd";
  };

  cargoSha256 = "0i5wy15w985nxwl4b6rzb06hchzjwph6ygzjkkmigm9diw9jcycn";

  buildInputs = [ llvmPackages.libclang llvmPackages.clang ];
  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  postInstall = ''
    mkdir -p $out/share/kak/autoload/plugins
    cp rc/parinfer.kak $out/share/kak/autoload/plugins/
    rtpPath=$out/share/vim-plugins/parinfer-rust
    mkdir -p $rtpPath/plugin
    sed "s,let s:libdir = .*,let s:libdir = '${placeholder "out"}/lib'," \
      plugin/parinfer.vim >$rtpPath/plugin/parinfer.vim
  '';

  meta = with stdenv.lib; {
    description = "Infer parentheses for Clojure, Lisp, and Scheme.";
    homepage = "https://github.com/eraserhd/parinfer-rust";
    license = licenses.isc;
    maintainers = with maintainers; [ eraserhd ];
    platforms = platforms.all;
  };
}
