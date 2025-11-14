{
  config,
  lib,
  ...
}: let
  cfg = config.sportshead.lang;
in {
  options = {
    sportshead.lang = {
      haskell = lib.mkEnableOption "haskell";
    };
  };
  config = {
    plugins.haskell-tools = lib.mkIf cfg.haskell {
      enable = true;
      enableTelescope = true;
    };
  };
}
