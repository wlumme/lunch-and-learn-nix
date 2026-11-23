# https://nixos.org/guides/nix-pills/07-working-derivation.html

export PATH="$coreutils/bin:$gcc/bin"
mkdir $out
gcc -o $out/simple $src