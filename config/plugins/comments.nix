{
  plugins.comment = {
    enable = true;
    settings.pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
  };

  plugins.ts-context-commentstring.enable = true;

  plugins.todo-comments = {
    enable = true;
    settings.signs = false;
  };
}
