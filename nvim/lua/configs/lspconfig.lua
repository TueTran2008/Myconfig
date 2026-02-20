require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyzer", "codelldb"}
vim.lsp.enable(servers)
vim.lsp.enable({"clangd"})

-- read :h vim.lsp.config for changing options of lsp servers 
