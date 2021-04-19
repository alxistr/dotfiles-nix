{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let ventoy = callPackage ./ventoy.nix { }; in

mkShell {
  buildInputs = [
    busybox
    exfat
    parted
    ventoy
  ];

  shellHook = ''
    tmpventoy=/var/tmp/ventoy/

    rm -r "$tmpventoy" || true
    mkdir -p $tmpventoy

    cp -a ${ventoy}/. $tmpventoy

    cd $tmpventoy
    chown -R $(id -u):$(id -g) .
    chmod -R u+rw .

    ls -l

    echo -e "\n\n\nusage: sudo ./Ventoy2Disk.sh -g -i <disk>\n\n"

  '';

}
