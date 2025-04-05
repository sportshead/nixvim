{
  colorscheme = "tokyonight";
  colorschemes.tokyonight = {
    enable = true;
    # lazyLoad.enable = true;

    settings = {
      style = "moon";
      transparent = true;
      dim_inactive = true;
      on_colors = "function(colors) colors.fg_gutter = '#5C6594' end";
    };
  };

  plugins.web-devicons.enable = true;
}
