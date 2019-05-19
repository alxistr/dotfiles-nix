{
  imports = [
    "${builtins.fetchTarball https://github.com/cleverca22/nixos-configs/tarball/76260ad60cd99d40ab25df1400b0663d48e736db}/qemu.nix"
    ./secrets.nix
    ./docker.nix
    ./documentation.nix
    ./gui.nix
    ./ssh.nix
    ./steam.nix
    ./virt.nix
    ./rpi3bp.nix
    ./users.nix
    ./generic.nix
    ./vpn.nix
    ./wireless.nix
  ];
}
