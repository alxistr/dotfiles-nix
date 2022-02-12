{ config, pkgs, lib, ... }:

let home-manager = builtins.fetchTarball {
  url = "https://github.com/nix-community/home-manager/archive/2860d7e3bb350f18f7477858f3513f9798896831.tar.gz";
  sha256 = "0zkhdf3d2pqr6lr2mibrngp0fjcpdjk9abc55kqp43mq05caq6f9";
}; in
with lib; with types;

{
  imports = [
    "${home-manager}/nixos"
  ];

  config = {
    environment.systemPackages = with pkgs; [
      sudo
    ];

    nix = {
      distributedBuilds = true;
      trustedUsers = [ "root" "user" ];
    };

    users.users = with pkgs; {
      root = {
        initialPassword = "root";
      };
      user = {
        isNormalUser = true;
        uid = 1000;
        initialPassword = "user";
        extraGroups = [
          "wheel"
          "vboxusers"
          "docker"
          "libvirtd"
          "netdev"
          "plugdev"
          "pgriffais"
        ];
        openssh.authorizedKeys.keys = config.own.ssh.authorized-keys;
      };
    };

    security.sudo.wheelNeedsPassword = false;

    home-manager.users."root" = import ../../dotfiles/home.nix;
    home-manager.users."user" = import ../../dotfiles/home.nix;

  };

}
