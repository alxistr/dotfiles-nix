{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ranger
    w3m
    unixtools.xxd
    odt2txt
    poppler_utils
  ];

  home.file.".config/ranger/rc.conf".text = builtins.readFile ./ranger/rc.conf;
  home.file.".config/ranger/rifle.conf".text = builtins.readFile ./ranger/rifle.conf;
  home.file.".config/ranger/scope.sh" = {
    text = builtins.readFile ./ranger/scope.sh;
    executable = true;
  };

}
