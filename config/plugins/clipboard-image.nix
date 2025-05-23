{pkgs, ...}: let
  inherit (pkgs) lib stdenv;
in {
  plugins.clipboard-image = {
    enable = true;
    clipboardPackage = lib.mkIf stdenv.isDarwin pkgs.pngpaste;

    settings.default.img_name.__raw = "function() return os.date('%Y%m%dT%H%M%S') end";

    lazyLoad = {
      enable = true;
      settings = {
        keys = [
          {
            __unkeyed-1 = "<leader>v";
            __unkeyed-2 = "<Cmd>PasteImg<CR>";
          }
        ];
      };
    };
  };
}
