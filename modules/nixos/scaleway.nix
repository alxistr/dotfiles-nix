{ config, pkgs, lib, ... }:

with lib; with types;
let own = config.own; in

{
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
  ];

  options = {
    own.scaleway = mkOption {
      default = false;
      type = bool;
    };
    own.allowTTY = mkOption {
      default = false;
      type = bool;
    };
  };

  config = mkIf config.own.scaleway {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.cleanTmpDir = true;

    boot.kernelParams = [
      (mkIf own.allowTTY "console=ttyS0,115200")
      "panic=30" "boot.panic_on_fail"
    ];

    fileSystems = {
      "/" = {
        device = "/dev/vda1";
        fsType = "ext4";
      };
      "/boot/" = {
        device = "/dev/vda15";
        fsType = "vfat";
      };
    };

    networking = {
      firewall.allowPing = false;
    };

    services = {
      openssh = {
        enable = true;
        ports = [ 22 ];
        passwordAuthentication = false;
      };

      disnix.enable = true;

      fail2ban = {
        enable = true;
        jails.DEFAULT = mkForce ''
          ignoreip = 127.0.0.1/8
          bantime = 2592000
          findtime = 600
          maxretry = 3
          backend = systemd
          enabled = true
        '';
      };

    };

    environment.systemPackages = with pkgs; [
      vim
      tmux
      ranger
      ncdu
      htop
      tcpdump
      inetutils
    ];

    system.activationScripts = {
      removeOldRoot = ''
        rm -rf /old-root
      '';
    };

  };

}
