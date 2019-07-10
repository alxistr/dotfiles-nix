{ pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./fish.nix
  ];

  home.packages = with pkgs; [
    pmutils
    procps
    htop
    atop
    iotop
    ncdu
    tree
    less
    unzip
    p7zip
    atool
    rlwrap
    jq
    fzf
    ag
    gnupg
    pass
    usbutils
    pciutils
    lm-sensors
    pv
  ];

  home.file.".inputrc".source = ./inputrc;
  home.file.".config/htop/htoprc".source = ./htoprc;

}
