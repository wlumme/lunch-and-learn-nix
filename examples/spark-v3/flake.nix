{
  description = "Spark v3 example flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs { inherit system; };
      jdk = pkgs.jdk11;
      python = pkgs.python311.withPackages (ps: with ps; [
        (
          pyspark.overrideAttrs (oldAttrs: rec {
            version = "3.5.0";
            src = pkgs.fetchPypi {
              pname = "pyspark";
              inherit version;
              hash = "sha256-1Bqbdr0qyjcKYQDQdcAp4iukTFlAknh36UNaOpxWZVg=";
            };
            pythonRelaxDeps = [ "py4j" ];
          })
        )
      ]);
    in pkgs.mkShell {
      packages = with pkgs; [
        jdk
        python
      ];

      shellHook = ''java --version; python --version; pyspark --version'';
    };
  };
}