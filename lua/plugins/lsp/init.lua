local lsp = require('lspconfig')
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
local on_attach = function(_, bufnr)
  local map = require('map').nnoremap;
  local bufopts = { buffer = bufnr }
  map("<leader>gd", vim.lsp.buf.definition, bufopts)
  map("<leader>gI", vim.lsp.buf.implementation, bufopts)
  map("<leader>gD",vim.lsp.buf.declaration, bufopts)
  map("<leader>h", vim.lsp.buf.hover, bufopts)
  map("<leader>s", vim.lsp.buf.signature_help, bufopts)
  map("<leader>r", vim.lsp.buf.rename, bufopts)
  map("<leader>ca",vim.lsp.buf.code_action, bufopts)
end
local capabilities = require('cmp_nvim_lsp')
  .default_capabilities(
  vim.lsp.protocol.make_client_capabilities())

local servers = require('plugins.lsp.servers')
for name, opts in pairs(servers) do
  opts.capabilities = capabilities
  opts.on_attach = on_attach
  lsp[name].setup(opts)
end
