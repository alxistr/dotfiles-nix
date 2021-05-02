{ pkgsi686Linux, stdenv, fetchurl, dpkg, file,
  makeWrapper, coreutils, ghostscript, gnugrep, gnused, which, perl }:

stdenv.mkDerivation {
  name = "dcpt310";

  src = fetchurl {
    url = "https://download.brother.com/welcome/dlf103618/dcpt310pdrv-1.0.1-0.i386.deb";
    sha256 = "0g9hylmpgmzd6k9lxjy32c7pxbzj6gr9sfaahxj3xzqyar05amdx";
  };

  nativeBuildInputs = [
    dpkg
    makeWrapper
  ];
  dontUnpack = true;
  dontPatchELF = true;
  dontStrip = true;

  phases = [ "installPhase" ];

  installPhase = ''
    dpkg-deb -x $src $out

    dir=$out/opt/brother/Printers/dcpt310

    substituteInPlace $dir/cupswrapper/brother_lpdwrapper_dcpt310 \
      --replace /usr/bin/perl ${perl}/bin/perl \
      --replace "\$basedir =~ s/\$PRINTER\/cupswrapper\/.*\$/\$PRINTER\//g;" \
                "\$basedir = \"$dir/\";" \
      --replace "my \$PPD = \$ENV{PPD};" \
                "my \$PPD = \"$dir/cupswrapper/brother_dcpt310_printer_en.ppd\";" \
      --replace "\$PRINTER =~ s/^\/opt\/.*\/Printers\///g;" "" \
      --replace "\$PRINTER =~ s/\/cupswrapper//g;" "" \
      --replace "\$PRINTER =~ s/\///g;" \
                "\$PRINTER = \"dcpt310\";"
    # --replace "\$DEBUG=0;" "\$DEBUG=2;" \
    wrapProgram $dir/cupswrapper/brother_lpdwrapper_dcpt310 \
      --prefix PATH : ${stdenv.lib.makeBinPath [
        coreutils ghostscript gnugrep gnused which file
      ]}

    substituteInPlace $dir/lpd/filter_dcpt310 \
      --replace /usr/bin/perl ${perl}/bin/perl \
      --replace "my \$PRINTER = \$0;" "my \$PRINTER = \"dcpt310\";" \
      --replace "my \$BR_PRT_PATH = Cwd::realpath (\$0);" \
                "my \$BR_PRT_PATH = \"$dir/\";" \
      --replace "\$BR_PRT_PATH =~ s/\$PRINTER\/lpd\/.*\$/\$PRINTER\//g;" ""
    # --replace "\$DEBUG = \$ENV{LPD_DEBUG}" "\$DEBUG = 1" \
    wrapProgram $dir/lpd/filter_dcpt310 \
      --prefix PATH : ${stdenv.lib.makeBinPath [
        coreutils ghostscript gnugrep gnused which file
      ]}

    mkdir -p $out/lib/cups/filter/
    ln -s \
      $dir/cupswrapper/brother_lpdwrapper_dcpt310 \
      $out/lib/cups/filter/

    mkdir -p $out/share/cups/model
    ln -s \
      $dir/cupswrapper/brother_dcpt310_printer_en.ppd \
      $out/share/cups/model/

    ## need to use i686 glibc here, these are 32bit proprietary binaries
    interpreter=${pkgsi686Linux.glibc}/lib/ld-linux.so.2
    touch $dir/.empty
    objcopy --add-section .gnu.hash=$dir/.empty $dir/lpd/brdcpt310filter
    patchelf --debug \
      --set-interpreter "$interpreter" \
      --set-rpath $dir/inf:$dir/lpd \
      $dir/lpd/brdcpt310filter
    objcopy --remove-section .gnu.hash $dir/lpd/brdcpt310filter

  '';

}
