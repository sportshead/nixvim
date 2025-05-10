{
  plugins.notify.enable = true;

  plugins.actions-preview = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        keys = [
          {
            __unkeyed-1 = "gf";
            __unkeyed-2.__raw = "function() require('actions-preview').code_actions() end";
            mode = ["v" "n"];
          }
        ];
      };
    };
  };
}
