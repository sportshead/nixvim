{
  plugins.treesitter = {
    enable = true;
    nixvimInjections = true;

    settings = {
      highlight.enable = true;

      indent.enable = true;
    };
  };

  plugins.treesitter-context = {
    enable = true;
    settings = {
      multiline_threshold = 8;
      max_lines = 10;
    };
  };

  plugins.hmts = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        ft = "nix";
      };
    };
  };
}
