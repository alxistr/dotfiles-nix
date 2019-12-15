{ config, pkgs, lib, ... }:

let enable = config.nixos-config.own.emacs; in
with lib; with types;

let doom-emacs = builtins.fetchGit {
  url = "https://github.com/hlissner/doom-emacs";
  # rev = "0000000000000000000000000000000000000000";  
}; in


{
  config = mkIf enable { 
    programs.emacs = {
      enable = true;
      extraPackages = epkgs: [ epkgs.emacs-libvterm ];
    };

    # home.file.".doom.d".source = ./.doom.d;
    # home.file.".emacs.d".source = doom-emacs;

  };

}
