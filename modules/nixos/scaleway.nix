{ config, pkgs, lib, ... }:

with lib; with types;
let own = config.own; in

let
  f2b-ignored-ips = (concatStringsSep " " (unique ([
    "127.0.0.1"
    "127.0.0.1/8"
  ] ++ own.f2b-whitelist)));
in

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
    own.f2b-whitelist = mkOption {
      default = [ ];
      type = listOf str;
    };
  };

  config = mkIf own.scaleway {
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 1;
    };
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
      "/boot" = {
        device = "/dev/vda15";
        fsType = "vfat";
      };
    };

    services.journald.extraConfig = ''
      SystemMaxUse=100M
    '';

    networking = {
      firewall = {
        allowPing = false;
        extraCommands = ''
            ( iptables-save | grep TCPMSS >/dev/null ) || ( iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu )
        '';
        };
    };

    services = {
      openssh = {
        enable = true;
        ports = [ 22 ];
        passwordAuthentication = false;
      };

      disnix.enable = false;

      fail2ban = {
        enable = true;
        jails.DEFAULT = mkForce (''
          ignoreip = ${f2b-ignored-ips}
          bantime = 2592000
          findtime = 600
          maxretry = 3
          backend = systemd
          enabled = true
        '');
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

    environment.etc."fail2ban/filter.d".source = mkForce (pkgs.runCommand "bld-f2b-filter" {} ''
      mkdir $out
      ln -s ${pkgs.fail2ban}/etc/fail2ban/filter.d/common.conf $out
      ln -s ${pkgs.fail2ban}/etc/fail2ban/filter.d/selinux-ssh.conf $out
      ln -s ${pkgs.fail2ban}/etc/fail2ban/filter.d/sshd.conf $out
    '');

    system.activationScripts = {
      removeOldRoot = ''
        rm -rf /old-root
      '';
    };

  };

}
