{ config, pkgs, lib, ... }:
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

  isoImage = {
    isoName = "${config.isoImage.isoBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";

    makeEfiBootable = true;
    makeUsbBootable = true;

    efiSplashImage = pkgs.fetchurl {
      url = https://raw.githubusercontent.com/NixOS/nixos-artwork/a9e05d7deb38a8e005a2b52575a3f59a63a4dba0/bootloader/efi-background.png;
      sha256 = "18lfwmp8yq923322nlb9gxrh5qikj1wsk6g5qvdh31c4h5b1538x";
    };
    splashImage = pkgs.fetchurl {
      url = https://raw.githubusercontent.com/NixOS/nixos-artwork/a9e05d7deb38a8e005a2b52575a3f59a63a4dba0/bootloader/isolinux/bios-boot.png;
      sha256 = "1wp822zrhbg4fgfbwkr7cbkr4labx477209agzc0hr6k62fr6rxd";
    };

    appendToMenuLabel = "";
    grubTheme = null;

  };

}
