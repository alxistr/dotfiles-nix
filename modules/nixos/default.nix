let nixos-configs = builtins.fetchGit {
  url = "https://github.com/cleverca22/nixos-configs.git";
  rev = "76260ad60cd99d40ab25df1400b0663d48e736db";
}; in 
{
  imports = [
    "${nixos-configs}/qemu.nix"
    ./secrets.nix
    ./docker.nix
    ./documentation.nix
    ./gui.nix
    ./ssh.nix
    ./steam.nix
    ./shell.nix
    ./virt.nix
    ./rpi3bp.nix
    ./users.nix
    ./generic.nix
    ./vpn.nix
    ./network.nix
    ./adhosts.nix
  ];
}
