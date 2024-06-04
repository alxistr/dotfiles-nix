{ config, pkgs, lib, ... }:

let home-manager = builtins.fetchTarball {
  url = "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
  sha256 = "sha256:13b22rkylwg4jwqmhyypkyjzm4algk5y43kfwwnb96wxmrqrplxc";
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
      settings.trusted-users = [ "root" "user" ];
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
          "kvm"
        ];
        openssh.authorizedKeys.keys = config.own.ssh.authorized-keys;
      };
    };

    security.sudo.wheelNeedsPassword = false;

    home-manager.sharedModules = [
      ( import ./nixpkgs.nix )
      ( import ../../dotfiles/home.nix )
    ];

  };

}
