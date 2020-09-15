{ config, pkgs, lib, ... }:

let opts = config.nixos-config.own.emacs; in
with lib; with types;

{
  config = mkIf opts.enable {
    programs.bash = {
      shellAliases = {
        emacs = "emacs -nw";
      };
    };

    home.packages = [
      pkgs.my-emacs
    ];

  };

}
