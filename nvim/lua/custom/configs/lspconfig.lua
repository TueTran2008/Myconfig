local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
-- local on_init = require("plugins.configs.lspconfig").on_init
local lspconfig = require ("lspconfig")
local util = require "lspconfig/util"

lspconfig.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Disable virtual_text
        virtual_text = false
      }
    ),
  }
}

lspconfig.clangd.setup {
  on_attach = function (client,bufnr) 
  client.server_capabilities.signatureHelpProvider = false
  on_attach(client,bufnr)
end,
  capabilities  = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Disable virtual_text
        virtual_text = false
      }
    ),
  }
}
lspconfig.lua_ls.setup {
  on_attach = on_attach,
	capabilities = capabilities
}
lspconfig.bitbake_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"language-server-bitbake",
    "--stdio"
	},
	filetypes = {
		"bitbake",
	}
}

lspconfig.robotframework_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"language-server-bitbake",
	},
	filetypes = {
		"robot",
    "resources",
	},
  settings = {
    robot = {
      pythonpath = {
      "/home/tuetd/Desktop/VN_SW_Automation/VN_Automation_Test/TB-362/libraries/python-genieacs",
      "/home/tuetd/Desktop/AutomationTest/TB-362/libraries",
      "/usr/local/bin",
      "/usr/lib/python3.10",
      "/usr/lib/python3.10/lib-dynload",
      "/home/tuetd/.local/lib/python3.10/site-packages",
      "/usr/local/lib/python3.10/dist-packages",
      "/usr/lib/python3/dist-packages",
      "/usr/lib/python310.zip"
      }
    }
  }
}
-- util.root_pattern('robotidy.toml', 'pyproject.toml', 'conda.yaml', 'robot.yaml')(fname)



