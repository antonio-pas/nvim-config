local M = {}

M.on_attach = function(_, buffer)
	local opts = { noremap = true, silent = true, buffer = buffer }
	vim.keymap.set("n", "<leader>hh", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

return M
