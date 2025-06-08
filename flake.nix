{
  description = "@sportshead's nixvim configuration flake";

  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  inputs = {
    nixpkgs.follows = "nixvim/nixpkgs";
    nixvim.url = "github:sportshead/nixvim-src/lsp-fallback";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    flake-parts,
    nixpkgs,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        system,
        inputs',
        pkgs,
        ...
      }: let
        inherit (inputs') nixvim;

        nixvimModule = {
          inherit system;
          module = import ./config;
          extraSpecialArgs = {
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfreePredicate = pkg:
                builtins.elem (nixpkgs.lib.getName pkg) [
                  "codeium"
                ];
            };
          };
        };
        nvim = nixvim.legacyPackages.makeNixvimWithModule nixvimModule;
      in {
        checks.default = nixvim.lib.check.mkTestDerivationFromNixvimModule nixvimModule;

        packages.default = nvim;

        formatter = pkgs.alejandra;

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.bashInteractive
            nvim
          ];
        };
      };
    };
}
