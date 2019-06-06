{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mosh
    curl
    wget
    traceroute
    tcpdump
    nettools
    sshfs
    w3m
    bind
    lsof
    proxychains
  ];

  home.file.".curlrc".source = ./curlrc;
  home.file.".wgetrc".source = ./wgetrc;
  home.file.".w3m/keymap".source = ./w3m-keymap;

}
