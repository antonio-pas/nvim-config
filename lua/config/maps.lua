local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>af', vim.lsp.buf.format, { desc = 'Format document' })
vim.keymap.set('n', '<leader>ar', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

vim.keymap.set('n', '<leader>to', function() require('telescope.builtin').builtin() end, { desc = 'Telescope' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = 'Telescope live grep' })
