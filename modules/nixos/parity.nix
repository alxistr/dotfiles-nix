{ config, pkgs, lib, ... }:

let cfg = config.own.parity; in
with lib; with types;

let
  mk-parity-toml = chain: cfg: pkgs.writeTextFile {
    name = "parity-${chain}.toml";
    # https://paritytech.github.io/parity-config-generator/
    text = ''
      [parity]
      mode = "${cfg.mode}"
      no_download = true
      light = ${boolToString cfg.light}
      chain = "${chain}"
      [rpc]
      apis = ["parity_transactions_pool", "web3", "eth", "net", "parity", "pubsub", "parity_pubsub", "rpc"]
      interface = "all"
      [websockets]
      disable = true
      [ipc]
      disable = true
      [secretstore]
      disable = true
    '' + (if cfg.warp-barrier == 0 then "" else ''
      [network]
      warp_barrier = ${toString cfg.warp-barrier}
    '');
  };

  mk-container-config = chain: cfg: {
    image = "openethereum/openethereum:v3.0.1";
    log-driver = "journald";
    ports = [
      "127.0.0.1:${toString cfg.rpc-port}:8545"
      # "127.0.0.1:8546:8546"
      # "127.0.0.1:30303:30303"
      # "127.0.0.1:30303:30303/udp"
    ];
    volumes = [
      "/var/db/parity-${chain}/:/home/openethereum/.local/share/openethereum/"
      "${mk-parity-toml chain cfg}:/var/tmp/cfg.toml"
    ];
    cmd = [ "-c" "/var/tmp/cfg.toml" ];
  };

in

{
  options.own.parity = mkOption {
    default = { };
    type = types.attrsOf (submodule {
      options = {
        rpc-port = mkOption {
          type = port;
          default = 8545;
        };
        mode = mkOption {
          type = enum [
            "active"
            "dark"
            "passive"
            "offline"
          ];
          default = "active";
        };
        light = mkOption {
          type = bool;
          default = true;
        };
        warp-barrier = mkOption {
          type = ints.unsigned;
          default = 0;
        };
      };
    });
  };

  config = mkIf (cfg != { }) {
    docker-containers = mapAttrs' (chain: cfg: nameValuePair
      "parity-${chain}"
      (mk-container-config chain cfg)
    ) cfg;
  };

}
