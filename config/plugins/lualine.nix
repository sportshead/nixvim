{
  pkgs,
  lib,
  ...
}: {
  extraPlugins = [
    pkgs.vimPlugins.lsp-progress-nvim
  ];

  plugins.lualine = {
    enable = true;

    settings = {
      sections = {
        lualine_a = ["mode"];
        lualine_b = ["branch" "diff" "diagnostics"];
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            newfile_status = true;
            path = 1;
          }
          (lib.nixvim.mkRaw ''
            function()
              return require("lsp-progress").progress({
                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                spin_update_time = 150,
              })
            end
          '')
        ];

        lualine_x = ["encoding" "fileformat" "filetype"];
        lualine_y = [
          {
            __unkeyed-1.__raw = ''
              function()
                  local function index_of(items, element, config)
                      local equals = config and config.equals or function(a, b) return a == b end
                      local index = -1
                      for i, item in ipairs(items) do
                          if equals(element, item) then
                              index = i
                              break
                          end
                      end

                      return index
                  end

                  local harpoon = require("harpoon")
                  local list = harpoon:list()

                  local item = list.config.create_list_item(list.config)
                  local index = index_of(list.items, item, list.config)
                  if index == -1 then return "" end

                  return index
              end
            '';
            icon = "󰛢";
          }
          (lib.nixvim.mkRaw ''
            function()
                return "{…}" .. require('codeium.virtual_text').status_string()
            end
          '')
        ];
        lualine_z = ["progress" "location"];
      };
    };
  };

  extraConfigLua = ''
    -- lsp-progress will explode if not setup since defaults are needed
    -- otherwise lsp-progress.progress() will try to call a nil value
    require('lsp-progress').setup()

    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_augroup",
      pattern = "LspProgressStatusUpdated",
      callback = require("lualine").refresh,
    })

    require('codeium.virtual_text').set_statusbar_refresh(function()
      require('lualine').refresh()
    end)
  '';
}
