{ config, pkgs, ... }:
{
  networking.hostName = "desktop";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  own = {
    ssh = {
      enable = true;
      agent = true;
    };
    gui = {
      enable = true;
      nvidia = true;
    };
    docker.enable = true;
    virtualisation.enable = true;
    steam.enable = true;
    dnsmasq = {
      enable = true;
      adhosts = true;
    };
    tor = {
      enable = true;
      # country = "US";
    };
  };

  # qemu-user.aarch64 = true;

}
