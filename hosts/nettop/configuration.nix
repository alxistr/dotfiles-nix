{ config, lib, pkgs, ... }:

let createMount = (uuid: {
  what = "/dev/disk/by-uuid/${uuid}";
  where = "/mnt/${uuid}";
  wantedBy = [ "multi-user.target" ];
}); in

with lib;

{
  networking.hostName = "nettop";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "pci=noaer" ];
  boot.cleanTmpDir = true;

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
      adhosts.enable = true;
    };
    tor = {
      enable = true;
      # country = "US";
    };
    mail.enable = true;
    emacs.enable = true;
  };

  # qemu-user.aarch64 = true;

  systemd.mounts = map (createMount) [
    "22551a16-fdaa-438b-bb31-264d848bccae"
  ];

  services.xserver.displayManager.sessionCommands = ''
    xrandr \
      --output HDMI-1-3 --off \
      --output HDMI-1-2 --mode 1920x1080 --pos 0x0 --rotate normal \
      --output HDMI-1-1 --off \
      --output DP-1-3 --off \
      --output DP-1-2 --off \
      --output DP-1-1 --mode 1920x1080 --pos 1920x0 --rotate normal
    xrandr --dpi 96
  '';

}
