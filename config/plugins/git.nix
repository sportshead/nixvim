{pkgs, ...}: {
  extraPackages = [pkgs.git];
  extraPlugins = [
    {
      plugin = pkgs.vimPlugins.vim-fugitive;
      optional = true;
    }
  ];
  plugins.lz-n.plugins = [
    {
      __unkeyed-1 = "vim-fugitive";
      cmd = ["G" "Git"];
    }
  ];

  plugins.gitsigns = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        event = "DeferredUIEnter";
      };
    };
  };
}
