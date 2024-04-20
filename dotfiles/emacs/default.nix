{ config, pkgs, lib, osConfig, ... }:

let opts = osConfig.own.emacs; in
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
