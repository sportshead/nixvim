{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.sportshead.lang;
  vim-syntax-shakespeare = pkgs.vimUtils.buildVimPlugin {
    name = "vim-syntax-shakespeare";
    src = pkgs.fetchFromGitHub {
      owner = "pbrisbin";
      repo = "vim-syntax-shakespeare";
      rev = "2f4f61eae55b8f1319ce3a086baf9b5ab57743f3";
      sha256 = "sha256-sdCXJOvB+vJE0ir+qsT/u1cHNxrksMnqeQi4D/Vg6UA=";
    };
  };
in {
  options = {
    sportshead.lang = {
      haskell = lib.mkEnableOption "haskell";
    };
  };
  config = lib.mkIf cfg.haskell {
    plugins.haskell-tools = {
      enable = true;
      enableTelescope = true;
    };
    extraPlugins = [
      vim-syntax-shakespeare
    ];
  };
}
