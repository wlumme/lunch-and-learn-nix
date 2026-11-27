# https://nixos.org/guides/nix-pills/07-working-derivation.html

let
  pkgs = import <nixpkgs> { };
in
derivation {
  name = "my-simple-derivation";
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./simple_builder.sh ];
  gcc = pkgs.gcc;
  coreutils = pkgs.coreutils;
  src = ./simple.c;
  system = builtins.currentSystem;
}
