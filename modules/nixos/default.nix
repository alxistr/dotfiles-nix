let nixos-configs = builtins.fetchGit {
  url = "https://github.com/cleverca22/nixos-configs.git";
  rev = "76260ad60cd99d40ab25df1400b0663d48e736db";
}; in
{
  imports = [
    "${nixos-configs}/qemu.nix"
    ./dnsmasq.nix
    ./docker-containers.nix
    ./docker.nix
    ./documentation.nix
    ./git.nix
    ./gui.nix
    ./mail.nix
    ./neovim.nix
    ./network.nix
    ./rpi3bp.nix
    ./shell.nix
    ./ssh.nix
    ./steam.nix
    ./tor.nix
    ./users.nix
    ./virt.nix
  ];
}
