{ pkgs, ... }:
{
  imports = [
    # ./bash.nix
    ./fish.nix 
  ];

  home.packages = with pkgs; [
    procps
    htop
    atop
    ncdu
    tree
    less
    atool
    rlwrap
    jq
    fzf
    ag
    gnupg
    pass
    usbutils
    lm_sensors
    pv
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  home.file.".inputrc".source = ./inputrc;
  home.file.".config/htop/htoprc".source = ./htoprc;

}
