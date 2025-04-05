{pkgs, ...}: {
  plugins.undotree.enable = true;
  keymaps = [
    {
      key = "<leader>u";
      action = "<cmd>UndotreeToggle<cr>";
    }
  ];
  plugins.nvim-surround = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        event = "InsertEnter";
      };
    };
  };

  extraPlugins = [
    {
      plugin = pkgs.vimPlugins.whitespace-nvim;
      optional = true;
    }
  ];

  plugins.lz-n.plugins = [
    {
      __unkeyed-1 = "whitespace.nvim";

      event = "BufReadPost";
      after = ''
        function()
            require("whitespace-nvim").setup()
        end
      '';

      keys = [
        {
          __unkeyed-1 = "<leader>t";
          __unkeyed-2.__raw = "function() require('whitespace-nvim').trim() end";
        }
      ];
    }
  ];
}
