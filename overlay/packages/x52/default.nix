{ stdenv, fetchFromGitHub,
  automake, autoconf, libtool, pkg-config, gettext, python3,
  libusb1, hidapi
 }:

stdenv.mkDerivation rec {
  pname = "x52pro-linux";
  version = "0.2.2";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "nirenjan";
    repo = "x52pro-linux";
    rev = "v${version}";
    sha256 = "0267ic43vj14pndscwalhbnnfb5bxxvnyafk6i1qms1i41zfr18m";
  };

  # hardeningDisable = [ "pic" ];

  outputs = [ "out" "dev" ];

  nativeBuildInputs = [
    autoconf
    automake
    libtool
    pkg-config
    gettext
    python3
    libusb1
    hidapi
  ];

  buildInputs = [
    libusb1
    hidapi
  ];

  preConfigure = "./autogen.sh";
  configureFlags = [
    "--disable-systemd"
    "--with-input-group=users"
    "--with-udevrulesdir=${placeholder "out"}/lib/udev/rules.d"
  ];

}
