return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    opts = function()
      local fzf = require("fzf-lua")
      local config = fzf.config
      local actions = fzf.actions

      -- FZF keymaps
      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
      config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
      config.defaults.keymap.fzf["ctrl-x"] = "jump"
      config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
      config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"

      config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
      config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

      local img_previewer

      for _, v in ipairs({
        { cmd = "ueberzug", args = {} },
        { cmd = "chafa", args = { "{file}", "--format=symbols" } },
        { cmd = "viu", args = { "-b" } },
      }) do
        if vim.fn.executable(v.cmd) == 1 then
          img_previewer = vim.list_extend({ v.cmd }, v.args)
          break
        end
      end

      return {
        fzf_colors = true,

        fzf_opts = {
          ["--no-scrollbar"] = true,
        },

        defaults = {
          formatter = "path.dirname_first",
        },

        previewers = {
          builtin = {
            extensions = {
              png = img_previewer,
              jpg = img_previewer,
              jpeg = img_previewer,
              gif = img_previewer,
              webp = img_previewer,
            },
            ueberzug_scaler = "fit_contain",
          },
        },

        winopts = {
          width = 0.8,
          height = 0.8,
          row = 0.5,
          col = 0.5,

          preview = {
            scrollchars = { "┃", "" },
          },
        },

        files = {
          cwd_prompt = false,

          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },

        grep = {
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },

        lsp = {
          symbols = {
            child_prefix = false,
          },

          code_actions = {
            previewer = vim.fn.executable("delta") == 1
                and "codeaction_native"
              or nil,
          },
        },
      }
    end,

    config = function(_, opts)
      require("fzf-lua").setup(opts)

      -- Make vim.ui.select use fzf-lua
      require("fzf-lua").register_ui_select()
    end,

    keys = {
      {
        "<leader>ff",
        function()
          require("fzf-lua").files()
        end,
        desc = "Find Files",
      },

      {
        "<leader>fg",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "Live Grep",
      },

      {
        "<leader>fb",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "Buffers",
      },

      {
        "<leader>fr",
        function()
          require("fzf-lua").oldfiles()
        end,
        desc = "Recent Files",
      },

      {
        "<leader>fh",
        function()
          require("fzf-lua").help_tags()
        end,
        desc = "Help Tags",
      },

      {
        "<leader>fc",
        function()
          require("fzf-lua").files({
            cwd = vim.fn.stdpath("config"),
          })
        end,
        desc = "Config Files",
      },

      {
        "<leader>gs",
        function()
          require("fzf-lua").git_status()
        end,
        desc = "Git Status",
      },

      {
        "<leader>gc",
        function()
          require("fzf-lua").git_commits()
        end,
        desc = "Git Commits",
      },

      {
        "<leader>sd",
        function()
          require("fzf-lua").diagnostics_workspace()
        end,
        desc = "Workspace Diagnostics",
      },

      {
        "<leader>sD",
        function()
          require("fzf-lua").diagnostics_document()
        end,
        desc = "Buffer Diagnostics",
      },

      {
        "<leader>sk",
        function()
          require("fzf-lua").keymaps()
        end,
        desc = "Keymaps",
      },

      {
        "<leader>ss",
        function()
          require("fzf-lua").lsp_document_symbols()
        end,
        desc = "Document Symbols",
      },

      {
        "<leader>sS",
        function()
          require("fzf-lua").lsp_live_workspace_symbols()
        end,
        desc = "Workspace Symbols",
      },
    },
  },
}
