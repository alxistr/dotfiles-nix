self: super:
let inherit (super) callPackage; in
{
  flat-remix = callPackage ./packages/flat-remix { };
  i3lockpp = callPackage ./packages/i3lockpp { };
  adhosts = callPackage ./packages/adhosts { };

  powerline-rs = callPackage (import ./packages/powerline-rs).override {
    pkgs = super;
  };
  # powerline-rs = callPackage (import ./packages/powerline-rs).build {
  #   inherit (super.darwin.apple_sdk.frameworks) Security;
  #   openssl = super.openssl_1_1;
  # };

  awesome-freedesktop = callPackage ./packages/lua-packages/awesome-freedesktop.nix { };

  bandcamp-downloader = callPackage ./packages/bandcamp-downloader { pythonPackages = self.python37Packages; };
  scdl = callPackage ./packages/scdl { pythonPackages = self.python37Packages; };
  fabric1 = callPackage ./packages/fabric1 { pythonPackages = self.python27Packages; };

  # xnview = callPackage ./packages/xnview { };

}
