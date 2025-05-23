local mason_registry = require('mason-registry')
local capabilities = require("plugins.configs.lspconfig").capabilities
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
--local liblldb_path = extension_path.. "lldb/lib/liblldb.dylib"
-- If you are on Linux, replace the line above with the line below:
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

vim.g.rustaceanvim = {
  
  tool = {
    hover_actions = {
      auto_focus = true,
    }
  },
  dap = {
    adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb_path, liblldb_path),
  },
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
    end,
    capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          inlayHints = {
            bindingModeHints = {
              enable = false,
            },
            chainingHints = {
              enable = false,
            },
            closingBraceHints = {
              enable = false,
              minLines = 25,
            },
            closureReturnTypeHints = {
              enable = "never",
            },
            lifetimeElisionHints = {
              enable = "never",
              useParameterNames = false,
            },
            maxLength = 25,
            parameterHints = {
              enable = false,
            },
            reborrowHints = {
              enable = "never",
            },
            renderColons = true,
            typeHints = {
              enable = true,
              hideClosureInitialization = false,
              hideNamedConstructor = false,
            },
            foreground = {
              typeHints = "#fdb6fdf0",
            },
          },
        },
      },
    }
}
