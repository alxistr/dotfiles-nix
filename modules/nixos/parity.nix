{ config, pkgs, lib, ... }:

let cfg = config.own.parity; in
with lib; with types;

let parity-toml = pkgs.writeTextFile {
  name = "parity.toml";
  text = cfg.toml;
}; in

{
  options.own.parity = {
    enable = mkEnableOption "";
    toml = mkOption {
      type = lines;
      # https://paritytech.github.io/parity-config-generator/#config=eyJfX2ludGVybmFsIjp7ImNvbmZpZ01vZGUiOiJhZHZhbmNlZCJ9LCJwYXJpdHkiOnsibW9kZSI6ImFjdGl2ZSIsIm5vX2Rvd25sb2FkIjp0cnVlLCJiYXNlX3BhdGgiOiJ+Ly5sb2NhbC9zaGFyZS8uaW8ucGFyaXR5LmV0aGVyZXVtIiwiZGJfcGF0aCI6In4vLmxvY2FsL3NoYXJlLy5pby5wYXJpdHkuZXRoZXJldW0vY2hhaW5zIiwia2V5c19wYXRoIjoifi8ubG9jYWwvc2hhcmUvLmlvLnBhcml0eS5ldGhlcmV1bS9rZXlzIiwibGlnaHQiOnRydWV9LCJycGMiOnsiYXBpcyI6WyJwYXJpdHlfdHJhbnNhY3Rpb25zX3Bvb2wiLCJ3ZWIzIiwiZXRoIiwibmV0IiwicGFyaXR5IiwicHVic3ViIiwicGFyaXR5X3B1YnN1YiIsInJwYyJdLCJpbnRlcmZhY2UiOiJhbGwifSwid2Vic29ja2V0cyI6eyJkaXNhYmxlIjp0cnVlfSwiaXBjIjp7ImRpc2FibGUiOnRydWV9LCJzZWNyZXRzdG9yZSI6eyJkaXNhYmxlIjp0cnVlfX0=
      default = ''
        [parity]
        # Parity continously syncs the chain
        mode = "active"
        # Disables auto downloading of new releases. Not recommended.
        no_download = true
        # Blockchain and settings will be stored in ~/.local/share/.io.parity.ethereum.
        base_path = "~/.local/share/.io.parity.ethereum"
        # Parity databases will be stored in ~/.local/share/.io.parity.ethereum/chains.
        db_path = "~/.local/share/.io.parity.ethereum/chains"
        # Your encrypted private keys will be stored in ~/.local/share/.io.parity.ethereum/keys.
        keys_path = "~/.local/share/.io.parity.ethereum/keys"
        # Experimental: run in light client mode. Light clients synchronize a bare minimum of data and fetch necessary data on-demand from the network. Much lower in storage, potentially higher in bandwidth. Has no effect with subcommands.
        light = true

        [rpc]
        # Only selected APIs will be exposed over this interface.
        apis = ["parity_transactions_pool", "web3", "eth", "net", "parity", "pubsub", "parity_pubsub", "rpc"]
        #  JSON-RPC will be listening for connections on IP all.
        interface = "all"

        [websockets]
        # UI won't work and WebSockets server will be not available.
        disable = true

        [ipc]
        # You won't be able to use IPC to interact with Parity.
        disable = true

        [secretstore]
        # You won't be able to encrypt and decrypt secrets.
        disable = true

      '';
    };
  };

  config = mkIf cfg.enable {
    docker-containers = {
      parity = {
        image = "openethereum/openethereum:v3.0.1";
        log-driver = "journald";
        ports = [
          "127.0.0.1:8545:8545"
          "127.0.0.1:8546:8546"
          "127.0.0.1:30303:30303"
          "127.0.0.1:30303:30303/udp"
        ];
        volumes = [
          "/var/db/parity/:/home/openethereum/.local/share/openethereum/"
          "${parity-toml}:/var/tmp/cfg.toml"
        ];
        cmd = [ "-c" "/var/tmp/cfg.toml" ];
      };
    };
  };

}
