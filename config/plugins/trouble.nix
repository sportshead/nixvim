{
  plugins.trouble = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        keys = [
          {
            __unkeyed-1 = "<leader>xx";
            __unkeyed-2.__raw = "function() require('trouble').toggle() end";
          }
          {
            __unkeyed-1 = "<leader>xw";
            __unkeyed-2.__raw = "function() require('trouble').toggle('workspace_diagnostics') end";
          }
          {
            __unkeyed-1 = "<leader>xd";
            __unkeyed-2.__raw = "function() require('trouble').toggle('document_diagnostics') end";
          }
          {
            __unkeyed-1 = "<leader>xq";
            __unkeyed-2.__raw = "function() require('trouble').toggle('quickfix') end";
          }
          {
            __unkeyed-1 = "<leader>xl";
            __unkeyed-2.__raw = "function() require('trouble').toggle('loclist') end";
          }
          {
            __unkeyed-1 = "gR";
            __unkeyed-2.__raw = "function() require('trouble').toggle('lsp_references') end";
          }
        ];
      };
    };
  };
}
