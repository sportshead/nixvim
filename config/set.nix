{
  opts = {
    nu = true;
    relativenumber = true;

    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = true;

    smartindent = true;

    wrap = false;

    swapfile = false;
    backup = false;
    undodir.__raw = "vim.fn.stdpath('state') .. '/undodir'";
    undofile = true;

    hlsearch = false;
    incsearch = true;

    termguicolors = true;

    scrolloff = 8;
    signcolumn = "yes";

    updatetime = 50;

    colorcolumn = "80";
  };

  extraConfigLua = ''
    vim.opt.isfname:append('@-@')

    -- endash (default is -N with capital)
    vim.fn.digraph_set('-n', '–')
    -- emdash
    vim.fn.digraph_set('-m', '—')
  '';
}
