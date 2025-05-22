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

  plugins.snacks = {
    enable = true;
    settings = {
      input.enabled = true;
      picker.enabled = true;
      rename.enabled = true;
    };
  };

  autoCmd = [
    {
      event = "User";
      pattern = "OilActionsPost";
      callback.__raw = ''
        function(event)
          if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end
      '';
    }
  ];
}
