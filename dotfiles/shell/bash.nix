{ pkgs, ... }:
let liquidprompt = builtins.fetchGit {
  url = "https://github.com/nojhan/liquidprompt/";
  rev = "488bb5975db9fa8be0b795019f0b6d99ec792f50";  # v_1.11
}; in
let shellAliases = import ./aliases.nix; in
{
  home.packages = with pkgs; [
    bashInteractive
    bash-completion
    powerline-rs
  ];

  programs.bash = {
    enable = true;
    historyControl = ["ignorespace" "ignoredups"];
    initExtra = ''
      for f in ~/.config/bash/includes/*; do
        source $f
      done
      for f in ~/.config/bash/conf.d/*; do
        source $f
      done
    '';
    inherit shellAliases;
  };
  home.file.".config/bash/includes".source = ./bash/functions;
  home.file.".config/bash/conf.d".source = ./bash/conf.d;
  home.file.".config/bash/liquidprompt".source = liquidprompt;
  home.file.".liquidpromptrc".source = ./bash/liquidpromptrc;

}
