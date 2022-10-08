{ config, pkgs, lib, ... }:
let cfg = config.own.keyd; in
with lib; with types;
{
  options.own.keyd = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    environment.etc = {
      "keyd/default.conf".source = pkgs.writeText "keyd.conf" ''
        [ids]
        *

        [main]
        capslock = overload(capslock, capslock)
        leftcontrol = layer(control)

        [capslock]
        h = left
        j = down
        k = up
        l = right

        [control:C]
        h = backspace

      '';
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
