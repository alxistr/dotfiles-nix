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
        y = home
        u = pagedown
        i = pageup
        o = end

        # [capslock:C]
        # [capslock:A]

        [control:C]
        h = backspace
        [ = esc

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
