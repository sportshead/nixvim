{lib, ...}: {
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "super-tab";
        "<Tab>" = [
          (lib.nixvim.mkRaw ''
            function(cmp)
                if cmp.snippet_active() then
                    cmp.accept()
                    return true
                elseif cmp.is_menu_visible() then
                    cmp.select_and_accept()
                    return true
                else
                    local codeium = require('codeium.virtual_text').accept()
                    if type(codeium) == "string" and codeium ~= "__codeium__accept_fallback" then
                        local keys = vim.api.nvim_replace_termcodes(codeium, true, false, true)
                        vim.api.nvim_feedkeys(keys, "i", false)
                        return true
                    end
                end
            end
          '')
          "snippet_forward"
          "fallback"
        ];

        "<C-h>" = ["show_signature" "hide_signature" "fallback"];
        "<C-k>" = ["fallback"];
      };

      signature.enabled = true;

      completion = {
        documentation.auto_show = true;
        list.selection.auto_insert = false;
      };

      sources = {
        default = ["lsp" "buffer" "snippets" "path"];
      };

      fuzzy.sorts = [
        (lib.nixvim.mkRaw ''
          function(a, b)
            if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
              return
            end
            return b.client_name == 'emmet_language_server'
          end
        '')

        "score"
        "sort_text"
      ];
    };
  };

  extraConfigLua = ''
    -- https://github.com/LazyVim/LazyVim/commit/15c81fdbb839f0c657fe4c077114475e82f423fe
    Snacks.util.on_key("<esc>", function()
      if vim.snippet then
        vim.snippet.stop()
      end
    end)
  '';

  plugins.windsurf-nvim = {
    enable = true;

    settings = {
      enable_cmp_source = false;
      virtual_text = {
        enabled = true;
        accept_fallback = "__codeium__accept_fallback";
        key_bindings = {
          accept = false;
          clear = "<M-\\";
          next = "<M-]";
          prev = "<M-[";
        };
      };
    };
  };
}
