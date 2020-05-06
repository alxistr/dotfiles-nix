{ pkgs, ... }:
{
  imports = [
    ./bash.nix
    # ./fish.nix
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
    unrar
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
    psmisc
    lm-sensors
    pv
    unixtools.xxd
    bat
  ];

  home.file.".inputrc".source = ./inputrc;
  home.file.".config/htop/htoprc".source = ./htoprc;

}
