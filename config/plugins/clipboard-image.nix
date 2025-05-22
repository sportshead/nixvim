{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf stdenv;
in {
  plugins.clipboard-image = {
    enable = true;
    clipboardPackage = mkIf stdenv.isDarwin pkgs.pngpaste;

    settings.img_name.__raw = "function() return os.date('%Y%m%dT%H%M%S') end";
  };
}
