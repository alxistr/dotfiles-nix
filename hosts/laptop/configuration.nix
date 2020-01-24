{ config, pkgs, ... }:
{
  networking.hostName = "laptop";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.cleanTmpDir = true;

  own = {
    ssh = {
      enable = true;
      agent = true;
    };
    gui.enable = true;
    docker.enable = true;
    virtualisation.enable = true;
    dnsmasq = {
      enable = true;
      adhosts.enable = true;
    };
    tor = {
      enable = true;
    };
    emacs.enable = true;
  };

  # qemu-user.aarch64 = true;

  networking.wireless.interfaces = [ "wlp2s0" ];

}
