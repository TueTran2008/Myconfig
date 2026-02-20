return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },

    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })

          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,

        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = { enable = true },
            },

            checkOnSave = true,

            diagnostics = {
              enable = true,
            },

            procMacro = { enable = true },

            files = {
              exclude = {
                ".direnv",
                ".git",
                ".jj",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
              watcher = "client",
            },
          },
        },
      },
    },
  --   config = function ()
  --     local mason_registry = require('mason-registry')
  --     local codelldb = mason_registry.get_package("codelldb")
  --     local extension_path = codelldb:get_install_path() .. "/extension/"
  --     local codelldb_path = extension_path .. "adapter/codelldb"
  --     --local liblldb_path = extension_path.. "lldb/lib/liblldb.dylib"
	-- -- If you are on Linux, replace the line above with the line below:
	--     local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
  --     local cfg = require('rustaceanvim.config')

  --     vim.g.rustaceanvim = {
  --       dap = {
  --         adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
  --       },
  --     }
    config = function(_, opts)
      -- ✅ NVChad way to check mason.nvim
      local has_mason =
        require("lazy.core.config").plugins["mason.nvim"] ~= nil

      if has_mason then
        local codelldb = vim.fn.exepath("codelldb")
        if codelldb ~= "" then
          local ext =
            (vim.loop.os_uname().sysname == "Linux") and ".so" or ".dylib"
          local library_path =
            vim.fn.expand("$MASON/opt/lldb/lib/liblldb" .. ext)

          opts.dap = {
            adapter = require("rustaceanvim.config")
              .get_codelldb_adapter(codelldb, library_path),
          }
        end
      end

      -- Apply opts globally (required by rustaceanvim)
      vim.g.rustaceanvim =
        vim.tbl_deep_extend("force", vim.g.rustaceanvim or {}, opts)

      -- ✅ NVChad error handling
      if vim.fn.executable("rust-analyzer") == 0 then
        vim.notify(
          "rust-analyzer not found in PATH\nhttps://rust-analyzer.github.io/",
          vim.log.levels.ERROR,
          { title = "rustaceanvim" }
        )
      end
    end,
  },
}
