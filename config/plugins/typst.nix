{
  config,
  lib,
  ...
}: let
  cfg = config.sportshead.lang;
in {
  options = {
    sportshead.lang = {
      typst = lib.mkEnableOption "typst";
    };
  };

  config = lib.mkIf cfg.typst {
    plugins.lsp.servers.tinymist = {
      enable = true;
      settings = {
        formatterMode = "typstyle";
        systemFonts = false;
        exportPdf = "onSave";
      };
    };

    files."ftplugin/typst.lua" = {
      keymaps = [
        {
          mode = "n";
          key = "<leader><leader>";
          action.__raw = ''
            function()
              local filename = vim.api.nvim_buf_get_name(0)
              vim.system({"zathura", filename:gsub("%.typ$", ".pdf")})
            end
          '';
        }
      ];
    };
  };
}
