{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.sportshead.lang;
in
{
  options = {
    sportshead.lang = {
      eslint = lib.mkEnableOption "eslint";
      clangd = lib.mkEnableOption "clangd";
    };
  };
  config = {
    extraConfigLua = ''
      _M.lsp_format_callback = function ()
        ${lib.optionalString cfg.eslint
          # lua
          ''
            vim.cmd("silent! LspEslintFixAll")
          ''
        }
          vim.lsp.buf.format({
              filter = function(client)
                  local lsp_blacklist = { "lua_ls", "vtsls", "eslint", "vue_ls" }
                  return not vim.tbl_contains(lsp_blacklist, client.name)
              end,
          })
      end
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      vim.api.nvim_clear_autocmds({ group = augroup })
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          callback = _M.lsp_format_callback,
      })
    '';

    plugins.lsp = {
      enable = true;

      servers = {
        vtsls = {
          enable = true;
        };
        vue_ls = {
          enable = true;
          filetypes = [ "vue" ];
        };
        nixd = {
          enable = true;
          filetypes = [ "nix" ];

          settings.options.nixvim.expr = ''(builtins.getFlake "github:sportshead/nixvim").packages.${pkgs.system}.default.options'';
        };
        gopls = {
          enable = true;
          settings.gopls = {
            gofumpt = true;
            staticcheck = true;
          };
        };
        emmet_language_server = {
          enable = true;
          filetypes = [
            "css"
            "eruby"
            "html"
            "javascript"
            "javascriptreact"
            "less"
            "sass"
            "scss"
            "pug"
            "typescriptreact"
            "vue"
            "astro"
            "mdx"
          ];
        };
        jedi_language_server = {
          enable = true;
        };
        eslint = lib.mkIf cfg.eslint {
          enable = true;
          extraOptions.handlers = {
            "eslint/noConfig".__raw =
              # lua
              ''
                function()
                    vim.notify("No eslint config found", vim.log.levels.WARN)
                    return {}
                end
              '';
          };
        };
        clangd = lib.mkIf cfg.clangd {
          enable = true;
          filetypes = [
            "c"
            "cpp"
            "objc"
            "objcpp"
            "cuda"
          ];
          settings.arguments = [ "--enable-config" ];
        };
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
      };

      keymaps.extra = [
        {
          mode = "n";
          key = "gl";
          action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        }
        {
          mode = "n";
          key = "[d";
          action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
        }
        {
          mode = "n";
          key = "]d";
          action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
        }
        {
          mode = "n";
          key = "K";
          action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        }
        {
          mode = "n";
          key = "gd";
          action = "<cmd>lua vim.lsp.buf.definition()<cr>";
        }
        {
          mode = "n";
          key = "gD";
          action = "<cmd>lua vim.lsp.buf.declaration()<cr>";
        }
        {
          mode = "n";
          key = "gri";
          action = "<cmd>lua vim.lsp.buf.implementation()<cr>";
        }
        {
          mode = "n";
          key = "grt";
          action = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
        }
        {
          mode = "n";
          key = "grr";
          action = "<cmd>lua vim.lsp.buf.references()<cr>";
        }
        {
          mode = "n";
          key = "grl";
          action = "<cmd>lua vim.lsp.codelens.run()<cr>";
        }
        {
          mode = "n";
          key = "gs";
          action = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
        }
        {
          mode = "n";
          key = "<F2>";
          action = "<cmd>lua vim.lsp.buf.rename()<cr>";
        }
        {
          mode = [
            "n"
            "x"
          ];
          key = "<F3>";
          action.__raw = "_M.lsp_format_callback";
        }
      ];
    };

    plugins.none-ls = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.event = [
          "BufReadPost"
          "BufNewFile"
        ];
      };

      sources = {
        formatting = {
          nixfmt.enable = true;
          biome.enable = true;
          black.enable = true;
          shfmt.enable = true;
          stylua.enable = true;

          clang_format.enable = cfg.clangd;
        };
      };
    };
  };
}
