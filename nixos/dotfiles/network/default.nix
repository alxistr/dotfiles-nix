{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mosh
    curl
    wget
    traceroute
    tcpdump
    nettools
    neomutt
    sshfs
    w3m
  ];

  home.file.".curlrc".source = ./curlrc;
  home.file.".wgetrc".source = ./wgetrc;
  home.file.".w3m/keymap".source = ./w3m-keymap;

}
