{
  description = "Spark v4 example flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs { inherit system; };
    in pkgs.mkShell {
      packages = with pkgs; [
        jdk21
        python314
        python314Packages.pyspark
      ];

      shellHook = ''java --version; python --version; pyspark --version'';
    };
  };
}