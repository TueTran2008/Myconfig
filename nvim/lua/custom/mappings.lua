local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["ZZ"] = { "<cmd> qa <CR>", "Quit nvim" }, -- New keymap
    ["<C-z>"] = { ":undo <CR>", "Undo"}, -- New keymap
  },
  -- Add insert mode
  i = {
    ["<C-z>"] = { "<C-o>u", "Undo" }, -- New keymap
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  }
}

M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "update crates"
    }
  }
}

return M