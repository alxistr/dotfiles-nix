{ pkgs, config, lib, ... }:
with lib; with types;
{
  options.own.secrets = {
    wireless = mkOption {
      default = { };
      type = nullOr attrs;
    };
    
    authorized-keys = mkOption {
      default = [ ];
      type = listOf string;
    };

    git = {
      server = mkOption {
        default = false;
        type = bool;
      };
      name = mkOption {
        default = null;
        type = nullOr string;
      };
      email = mkOption {
        default = null;
        type = nullOr string;
      };
    };

    vpn = mkOption {
      default = { };
      type = attrs;
    };

  };

}
