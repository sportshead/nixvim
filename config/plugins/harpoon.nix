{pkgs, ...}: {
  extraPlugins = [
    {
      plugin = pkgs.vimPlugins.harpoon2;
      optional = true;
    }
  ];

  plugins.lz-n.plugins = [
    {
      __unkeyed-1 = "harpoon2";

      after = ''
        function()
            require('harpoon').setup({
                settings = {
                    save_on_toggle = true,
                },
            })
        end
      '';

      keys = [
        {
          __unkeyed-1 = "<leader>a";
          __unkeyed-2.__raw = "function() require('harpoon'):list():add() end";
        }
        {
          __unkeyed-1 = "<C-e>";
          __unkeyed-2.__raw = ''
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
          '';
        }

        {
          __unkeyed-1 = "<leader>1";
          __unkeyed-2.__raw = "function() require('harpoon'):list():select(1) end";
        }
        {
          __unkeyed-1 = "<leader>2";
          __unkeyed-2.__raw = "function() require('harpoon'):list():select(2) end";
        }
        {
          __unkeyed-1 = "<leader>3";
          __unkeyed-2.__raw = "function() require('harpoon'):list():select(3) end";
        }
        {
          __unkeyed-1 = "<leader>4";
          __unkeyed-2.__raw = "function() require('harpoon'):list():select(4) end";
        }

        # Toggle previous & next buffers stored within Harpoon list
        {
          __unkeyed-1 = "<C-S-P>";
          __unkeyed-2.__raw = "function() require('harpoon'):list():prev() end";
        }
        {
          __unkeyed-1 = "<C-S-N>";
          __unkeyed-2.__raw = "function() require('harpoon'):list():next() end";
        }
      ];
    }
  ];
}
