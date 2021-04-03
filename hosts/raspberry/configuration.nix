{ config, pkgs, ... }:
{
  own.rpi3bp.enable = true;
  networking.wireless.interfaces = [ "wlan0" ];
}
