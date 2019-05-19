self: super:
let inherit (super) callPackage; in
{
  flat-remix = callPackage ./packages/flat-remix { };
  i3lockpp = callPackage ./packages/i3lockpp { };

  powerline-rs = callPackage (import ./packages/powerline-rs).override {
    pkgs = super;
  };
  # powerline-rs = callPackage (import ./packages/powerline-rs).build {
  #   inherit (super.darwin.apple_sdk.frameworks) Security;
  #   openssl = super.openssl_1_1;
  # };

  awesome-freedesktop = callPackage ./packages/lua-packages/awesome-freedesktop.nix { };

  # xnview = callPackage ./packages/xnview { };

}
