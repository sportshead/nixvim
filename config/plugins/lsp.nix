{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.sportshead.lsp;
in {
  options = {
    sportshead.lsp = {
      eslint = lib.mkEnableOption "eslint";
    };
  };
  config = {
    extraConfigLua = ''
      _M.lsp_format_callback = function ()
        ${
        if cfg.eslint
        then
          # lua
          ''
            vim.cmd("silent! EslintFixAll")
          ''
        else
          # lua
          ''
            vim.lsp.buf.format({
                filter = function(client)
                    local lsp_blacklist = { "lua_ls", "vtsls", "eslint" }
                    return not vim.tbl_contains(lsp_blacklist, client.name)
                end,
            })
          ''
      }
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
          filetypes = ["typescript" "javascript" "javascriptreact" "typescriptreact" "vue"];
          extraOptions.settings.vtsls = {
            tsserver = {
              globalPlugins = [
                {
                  name = "@vue/typescript-plugin";
                  location = "${config.plugins.lsp.servers.volar.package}/lib/node_modules/@vue/language-server";
                  languages = ["vue"];
                  configNamespace = "typescript";
                  enableForWorkspaceTypeScriptVersions = true;
                }
              ];
            };
          };
        };
        volar = {
          enable = true;
          filetypes = ["vue"];
        };
        nixd = {
          enable = true;
          filetypes = ["nix"];

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
        clangd = {
          enable = true;
          filetypes = ["c" "cpp" "objc" "objcpp" "cuda"];
          settings.arguments = ["--enable-config"];
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
        hls = {
          enable = true;
          filetypes = ["haskell" "lhaskell" "cabal"];
          installGhc = false;
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
          key = "gi";
          action = "<cmd>lua vim.lsp.buf.implementation()<cr>";
        }
        {
          mode = "n";
          key = "go";
          action = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
        }
        {
          mode = "n";
          key = "gr";
          action = "<cmd>lua vim.lsp.buf.references()<cr>";
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
          mode = ["n" "x"];
          key = "<F3>";
          action.__raw = "_M.lsp_format_callback";
        }
        {
          mode = "n";
          key = "<F4>";
          action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        }
        {
          mode = "i";
          key = "<C-h>";
          action = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
        }
      ];
    };

    plugins.none-ls = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.event = ["BufReadPost" "BufNewFile"];
      };

      sources = {
        formatting = {
          alejandra.enable = true;
          biome.enable = true;
          black.enable = true;
          clang_format.enable = true;
          shfmt.enable = true;
          stylua.enable = true;
        };
      };
    };
  };
}
