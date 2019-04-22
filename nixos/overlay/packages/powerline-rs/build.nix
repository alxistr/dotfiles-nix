{ stdenv, lib, rustPlatform, fetchFromGitLab, pkgconfig, file, perl, curl, cmake, openssl, libssh2, libgit2, libzip, Security }:
rustPlatform.buildRustPackage rec {
  pname = "powerline-rs";
  name = "${pname}-${version}";
  version = "0.1.9+1b7e39ed";

  src = fetchFromGitLab {
    owner = "jD91mZM2";
    repo = "powerline-rs";
    rev = "1b7e39ed1f0a65d172288121569430e0ab467536"; 
    sha256 = "0fx6dr1rwz2kfvz63knbaqkvwbzzl3q9xcdzzqs0dw2a7293birb";
  };

  cargoSha256 = "1sr9vbfk5bb3n0lv93y19in1clyvbj0w3p1gmp4sbw8lx84zwxhc";

  nativeBuildInputs = [ pkgconfig file perl cmake curl ];
  buildInputs = [ openssl libssh2 libgit2 libzip ] ++ lib.optional stdenv.isDarwin Security;

  COMPLETION_OUT = "out";
  postInstall = ''
    install -Dm 755 "${COMPLETION_OUT}/${pname}.bash" "$out/etc/bash_completion.d/${pname}"
    install -Dm 755 "${COMPLETION_OUT}/${pname}.fish" "$out/share/fish/vendor_completions.d/${pname}"
  '';

  meta = with lib; {
    description = "powerline-shell rewritten in Rust, inspired by powerline-go";
    license = licenses.mit;
    maintainers = with maintainers; [ jD91mZM2 ];
    platforms = platforms.unix;
  };
}
