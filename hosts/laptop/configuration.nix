{ config, pkgs, ... }:
{
  networking.hostName = "laptop";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  own = {
    gui.enable = true;
    docker.enable = true;
    virtualisation.enable = true;
    dnsmasq = {
      enable = true;
      adhosts.enable = true;
    };
  };

  # qemu-user.aarch64 = true;

  virtualisation.kvmgt = {
    enable = true;
    vgpus = {
      "i915-GVTg_V5_8" = {
        uuid = [ "e2658672-c172-11ed-b8d2-b340a9da981e" ];
      };
    };
  };

  networking.wireless.interfaces = [ "wlp2s0" ];

}
