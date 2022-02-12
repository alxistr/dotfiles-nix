{ config, pkgs, lib, ... }:
let cfg = config.own.virtualisation; in
with lib; with types;
{
  options.own.virtualisation = {
    enable = mkEnableOption "virt";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virt-manager
      virtualbox
    ];
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.package = pkgs.qemu_kvm;
      };
      # docker.enableNvidia = true;
    };
  };

}
