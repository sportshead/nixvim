{pkgs, ...}: {
  plugins.oil = {
    enable = true;
    settings.view_options.is_hidden_file =
      # lua
      ''
        function(name)
            if name == ".git" then return true end
            if name == "node_modules" then return true end
            if vim.endswith(name, ".o") then return true end

            return false
        end
      '';

    package = pkgs.vimPlugins.oil-nvim.overrideAttrs {
      preInstall = ''
        # collision with blink.cmp
        rm doc/recipes.md
      '';
    };
  };

  # set global keymap
  keymaps = [
    {
      action = "<cmd>Oil<cr>";
      key = "-";
    }
  ];
}
