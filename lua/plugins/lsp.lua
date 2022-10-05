local lsp = require('lspconfig')
local luaSettings = {
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
}
local lsp_flags = {
  debounce_text_changes = 150
}
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, bufopts)
end
local capabilities = require('cmp_nvim_lsp')
  .update_capabilities(
  vim.lsp.protocol.make_client_capabilities())
lsp.ccls.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})
lsp.rust_analyzer.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})
lsp.sumneko_lua.setup({
  capabilities = capabilities,
  settings = luaSettings,
  flags = lsp_flags,
  on_attach = on_attach,
})
