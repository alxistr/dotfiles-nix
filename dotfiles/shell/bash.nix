{ pkgs, ... }:
let liquidprompt = builtins.fetchGit {
  url = "https://github.com/nojhan/liquidprompt/"; 
  rev = "v_1.11"; 
}; in
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

