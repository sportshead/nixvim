{
  imports =
    [
      ./set.nix
      ./remap.nix
      ./ft.nix
    ]
    ++ builtins.map (file: ./plugins/${file}) (builtins.attrNames (builtins.readDir ./plugins));

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
