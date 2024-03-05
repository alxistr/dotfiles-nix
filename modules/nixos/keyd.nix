{ config, pkgs, lib, ... }:
let cfg = config.own.keyd; in
with lib; with types;
{
  options.own.keyd = {
    enable = (mkEnableOption "") // { default = true; };
  };

  config = mkIf cfg.enable {
    environment.etc = {
      # https://github.com/rvaiya/keyd/blob/master/docs/keyd.scdoc
      "keyd".source = ./keyd;
    };

    systemd.services.keyd = {
      wantedBy = [ "graphical.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.keyd}/bin/keyd'';
        Restart = "always";
      };
    };
  };

}
