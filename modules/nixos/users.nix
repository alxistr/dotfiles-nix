{ config, pkgs, lib, ... }:

let home-manager = builtins.fetchTarball {
  url = "https://github.com/nix-community/home-manager/archive/ac2287df5a2d6f0a44bbcbd11701dbbf6ec43675.tar.gz";
  sha256 = "1bn5m4qlzxc5c264hwyy9n8f7m1pzc79fd0xh18n46wn0v8vx4jn";
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
