{ stdenv, fetchFromGitHub,
  automake, autoconf, libtool, pkg-config, gettext, python3,
  libusb1, hidapi
 }:

stdenv.mkDerivation rec {
  pname = "x52pro-linux";
  version = "0.2.1";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "nirenjan";
    repo = "x52pro-linux";
    rev = "v${version}";
    sha256 = "1g0d60cnhgyjpzypg2g9ibq3k5615sj0gcs3iyx3mv1wwy1j3r5g";
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
    "--with-input-group=users"
    "--with-udevrulesdir=${placeholder "out"}/lib/udev/rules.d"
  ];

}
