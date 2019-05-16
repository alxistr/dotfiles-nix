{ pkgs, ... }:
let liquidprompt = builtins.fetchTarball "https://github.com/nojhan/liquidprompt/archive/v_1.11.tar.gz"; in
let shellAliases = import ./aliases.nix; in
{
  home.packages = with pkgs; [
    bashInteractive
    bash-completion
  ];

  programs.bash = {
    enable = true;
    historyControl = ["ignorespace" "ignoredups"];
    initExtra = ''
      for f in ~/.config/bash/includes/*; do
        source $f
      done
      source ~/.config/bash/liquidprompt/liquidprompt
    '';
    inherit shellAliases;
  };
  home.file.".config/bash/includes".source = ./bash/functions;
  home.file.".config/bash/liquidprompt".source = liquidprompt;
  home.file.".liquidpromptrc".source = ./bash/liquidpromptrc;

}

