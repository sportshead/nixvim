{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    nixvimInjections = true;

    settings = {
      highlight.enable = true;

      indent.enable = true;
    };
  };

  plugins.treesitter-context = {
    enable = true;
    settings = {
      multiline_threshold = 8;
      max_lines = 10;
    };
  };

  plugins.hmts = {
    enable = true;

    package = pkgs.vimUtils.buildVimPlugin {
      name = "hmts";

      src = pkgs.fetchFromGitHub {
        owner = "calops";
        repo = "hmts.nvim";
        rev = "c3014b514ccb8f1975828b8f5a009ef93f9b4ced";
        hash = "sha256-pfdoZbKr/OXd7K8zcp8kSjQTy6AFFdck1NauqHFDfPM=";
      };
    };

    lazyLoad = {
      enable = true;
      settings = {
        ft = "nix";
      };
    };
  };
}
