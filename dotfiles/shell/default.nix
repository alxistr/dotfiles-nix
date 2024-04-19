{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pmutils
    procps
    htop
    atop
    iotop
    iftop
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
    silver-searcher
    gnupg
    pass
    usbutils
    pciutils
    psmisc
    shell-tools.lm-sensors
    pv
    unixtools.xxd
    bat
    inotify-tools

    liquidprompt
    bashInteractive
    bash-completion
    shell-tools.create-docker-template
    shell-tools.oom-pls
    shell-tools.dump-colors
    shell-tools.draw-in-palette
    shell-tools.inotify-watch

  ];

  programs.bash = {
    enable = true;
    historyControl = ["ignorespace" "ignoredups"];
    initExtra = ''
      source liquidprompt
      export FZF_DEFAULT_OPTS='--color=light'
      export BAT_THEME=ansi-dark
      if command -v fzf-share >/dev/null; then
        source "$(fzf-share)/key-bindings.bash"
        source "$(fzf-share)/completion.bash"
      fi
      # source ${./fzf-bash-completion}
      # bind -x '"\t": fzf_bash_completion'
      source ${pkgs.shell-tools.bash-functions}
    '';
    shellAliases = import ./aliases.nix;
  };

  home.file.".inputrc".source = ./inputrc;
  home.file.".config/htop/htoprc".source = ./htoprc;
  home.file.".liquidpromptrc".source = ./liquidpromptrc;

}
