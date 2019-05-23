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
      virtualbox
    ];
    virtualisation.libvirtd.enable = true;
  };

}
