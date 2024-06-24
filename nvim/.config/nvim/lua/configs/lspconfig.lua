-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
-- elixir
-- lspconfig.elixirls.setup {
--   cmd = { "/Users/ricardo/.local/share/nvim/mason/bin/elixir-ls" },
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }
-- elixir
-- lspconfig.nextls.setup {
--   cmd = { "/Users/ricardo/.local/share/nvim/mason/bin/nextls", "--stdio" },
--   -- cmd = { "nc", "127.0.0.1", "9000" },
--   init_options = {
--     extensions = {
--       credo = { enable = true }
--     },
--     experimental = {
--       completions = { enable = true }
--     }
--   },
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }
