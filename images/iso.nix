{ config, pkgs, lib, ... }:

let
  # squashfs-compression = "xz -Xdict-size 100%";
  squashfs-compression = "gzip -noD -noF -noX -noI";
in

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
    <nixpkgs/nixos/modules/profiles/all-hardware.nix>
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../modules/generic
    ../modules/nixos
  ] ++ lib.optional (builtins.pathExists ../local-iso.nix) ../local-iso.nix;

  networking.hostName = "iso";

  boot.loader.grub.memtest86.enable = true;

  own = {
    ssh = {
      enable = true;
    };
    gui.enable = true;
    docker.enable = true;
    virtualisation.enable = true;
  };

  system.build.squashfsStore = pkgs.callPackage <nixpkgs/nixos/lib/make-squashfs.nix> {
    storeContents = config.isoImage.storeContents;
    comp = squashfs-compression;
  };

  isoImage = {
    isoName = "${config.isoImage.isoBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";

    makeEfiBootable = true;
    makeUsbBootable = true;

    efiSplashImage = "${pkgs.wallpapers}/IMG_209880gs.jpg";
    splashImage = "${pkgs.wallpapers}/IMG_209880gs.jpg";

    appendToMenuLabel = "";
    grubTheme = null;

  };

}
