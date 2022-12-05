local map = require('map').nnoremap
map('<leader>d', ":lua vim.diagnostic.open_float<cr>")
map('<leader>pd', ":lua vim.diagnostic.goto_prev<cr>")
map('<leader>nd', ":lua vim.diagnostic.goto_next<cr>")
map('<leader>sd', ":lua vim.diagnostic.setloclist<cr>")

map('<C-p>', ':bprev<cr>')
map('<C-n>', ':bnext<cr>')
