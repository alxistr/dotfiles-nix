{ config, lib, pkgs, ... }:

let createMount = (uuid: {
  what = "/dev/disk/by-uuid/${uuid}";
  where = "/mnt/${uuid}";
  wantedBy = [ "multi-user.target" ];
}); in

with lib;

{
  networking.hostName = "desktop";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelParams = [ "pci=noaer" ];
  boot.cleanTmpDir = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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
    # tor = {
    #   # enable = true;
    #   # country = "US";
    # };
    # mail.enable = true;
    # emacs.enable = true;
  };

#  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
#  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  services.xserver.wacom.enable = true;

  # systemd.mounts = map (createMount) [
  #   "22551a16-fdaa-438b-bb31-264d848bccae"
  # ];

  services.xserver.displayManager.sessionCommands = ''
    xrandr \
      --output DVI-D-0 --off \
      --output HDMI-0 --off \
      --output DP-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
      --output DP-1 --off \
      --output DP-2 --off \
      --output DP-3 --off \
      --output DP-4 --off \
      --output DP-5 --off \
      --output HDMI-1-1 --mode 1920x1080 --pos 3840x0 --rotate right \
      --output DP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal \
      --output HDMI-1-2 --off
    xrandr --dpi 96
  '';

}
