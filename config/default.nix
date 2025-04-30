{
  imports = [
    ./set.nix
    ./remap.nix
    ./ft.nix

    ./plugins/lz-n.nix
    ./plugins/theme.nix
    ./plugins/lsp.nix
    ./plugins/cmp.nix
    ./plugins/harpoon.nix
    ./plugins/editing.nix
    ./plugins/oil.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/lualine.nix
    ./plugins/comments.nix
    ./plugins/git.nix
  ];

  enableMan = false;

  viAlias = true;
  vimAlias = true;

  luaLoader.enable = true;
  performance = {
    combinePlugins = {
      enable = true;
      standalonePlugins = [
        "nvim-treesitter"
      ];
      pathsToLink = [
        # blink.cmp native fuzzy funder
        "/target/release"
      ];
    };

    byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
}
