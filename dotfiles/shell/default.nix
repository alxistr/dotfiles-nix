{ pkgs, ... }:

{
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
    shell-tools.lm-sensors
    pv
    unixtools.xxd
    bat

    bashInteractive
    bash-completion
    shell-tools.create-docker-template
    shell-tools.oom-pls
    shell-tools.dump-colors
    shell-tools.draw-in-palette

  ];

  programs.bash = {
    enable = true;
    historyControl = ["ignorespace" "ignoredups"];
    initExtra = ''
      function lqp () {
        source ${pkgs.shell-tools.liquidprompt}/liquidprompt
      }
      if [[ -z $IN_NIX_SHELL ]]; then lqp; fi
      export FZF_DEFAULT_OPTS='--color=light'
      export BAT_THEME=ansi-dark
      if command -v fzf-share >/dev/null; then
        source "$(fzf-share)/key-bindings.bash"
        source "$(fzf-share)/completion.bash"
      fi
      source ${pkgs.shell-tools.bash-functions}
    '';
    shellAliases = import ./aliases.nix;
  };

  # programs.starship = {
  #   enable = true;
  #   settings = {
  #     character = { };
  #   };
  # };

  home.file.".inputrc".source = ./inputrc;
  home.file.".config/htop/htoprc".source = ./htoprc;
  home.file.".liquidpromptrc".source = ./liquidpromptrc;

}
