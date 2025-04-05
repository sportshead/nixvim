{pkgs, ...}: {
  plugins.notify.enable = true;

  extraPlugins = [
    {
      plugin = pkgs.vimPlugins.actions-preview-nvim;
      optional = true;
    }
  ];
  plugins.lz-n.plugins = [
    {
      __unkeyed-1 = "actions-preview.nvim";
      keys = [
        {
          __unkeyed-1 = "gf";
          __unkeyed-2.__raw = "function() require('actions-preview.actions').code_actions() end";
          mode = ["v" "n"];
        }
      ];
    }
  ];
}
