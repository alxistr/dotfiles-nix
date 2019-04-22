import <nixpkgs> {
  overlays = [
    ( import ./default.nix )
  ];
}
# { pkgsPath ? <nixpkgs> }:
# import pkgsPath {
#   overlays = [
#     ( import ./default.nix )
#   ];
# }
