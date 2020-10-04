{ config, pkgs, lib, ... }:

let home-manager = builtins.fetchTarball {
  url = "https://github.com/nix-community/home-manager/archive/e6f96b6aa3e99495f9f6f3488ecf78dd316e5bec.tar.gz";
  sha256 = "1xvxqw5cldlhcl7xsbw11n2s3x1h2vmbm1b9b69a641rzj3srg11";
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
        ];
        openssh.authorizedKeys.keys = config.own.ssh.authorized-keys;
      };
    };

    security.sudo.wheelNeedsPassword = false;

    home-manager.users."root" = import ../../dotfiles/home.nix;
    home-manager.users."user" = import ../../dotfiles/home.nix;

  };

}
