let nixos-configs = builtins.fetchGit {
  url = "https://github.com/cleverca22/nixos-configs.git";
  rev = "76260ad60cd99d40ab25df1400b0663d48e736db";
}; in
{
  imports = [
    "${nixos-configs}/qemu.nix"
    ./dnsmasq.nix
    # ./docker-containers.nix
    ./docker.nix
    ./documentation.nix
    ./emacs.nix
    ./git.nix
    ./gui.nix
    ./mail.nix
    ./modem.nix
    ./neovim.nix
    ./network.nix
    ./oom.nix
    ./rpi3bp.nix
    ./shell.nix
    ./ssh.nix
    ./steam.nix
    ./tor.nix
    ./users.nix
    ./virt.nix
    ./zeronet.nix
  ];
}
