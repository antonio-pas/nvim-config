local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>pd', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>nd', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>sd', vim.diagnostic.setloclist, opts)

vim.keymap.set('n', '<C-p>', ':bprev<cr>', opts)
vim.keymap.set('n', '<C-n>', ':bnext<cr>', opts)
