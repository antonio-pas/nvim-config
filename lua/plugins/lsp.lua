local lsp = require('lspconfig')
local on_attach = function(_, bufnr)
  local map = require('map').nnoremap;
  local bufopts = { buffer = bufnr }
  map("<leader>g", ":lua vim.lsp.buf.definition()<cr>", bufopts)
  map("<leader>gD",":lua vim.lsp.buf.declaration()<cr>", bufopts)
  map("<leader>h", ":lua vim.lsp.buf.hover()<cr>", bufopts)
  map("<leader>s", ":lua vim.lsp.buf.signature_help()<cr>", bufopts)
  map("<leader>r", ":lua vim.lsp.buf.rename<cr>", bufopts)
  map("<leader>ca", ":lua vim.lsp.buf.code_action<cr>", bufopts)
end
local capabilities = require('cmp_nvim_lsp')
  .default_capabilities(
  vim.lsp.protocol.make_client_capabilities())
local servers = {'ccls', 'emmet_ls', 'html', 'tsserver'}
for _, server in ipairs(servers) do
  lsp[server].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })
end

lsp.rust_analyzer.setup({
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      server = {
        path = "/home/antonio/.rustup/toolchains/nightly-aarch64-unknown-linux-gnu/bin/rust-analyzer"
      }
    }
  },
  on_attach = on_attach,
})

lsp.sumneko_lua.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach,
})
