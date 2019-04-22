{ pkgs, config, lib, ... }:
with lib;
with types;
rec {
  options.own.secrets = {
    wireless = mkOption {
      default = { };
      type = nullOr attrs;
    };
    authorized-keys = mkOption {
      default = false;
      type = listOf string;
    };
    git = {
      server = mkOption {
        default = null;
        type = nullOr bool;
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
      type = nullOr attrs;
    };
  };

  config =
  {
    own.secrets = {
      wireless = { };
      authorized-keys = [ ];
      git = {
        server = null;
        name = null;
        email = null;
      };
      vpn = { };
    } // (import ../secrets.nix);
  };

}
