local map = require('map').nnoremap
map('<leader>do', "<cmd>lua vim.diagnostic.open_float()<cr>")
map('<leader>dp', "<cmd>lua vim.diagnostic.goto_prev()<cr>")
map('<leader>dn', "<cmd>lua vim.diagnostic.goto_next()<cr>")
map('<leader>da', "<cmd>lua vim.diagnostic.setloclist()<cr>")

map('<C-p>', '<cmd>bprev<cr>')
map('<C-n>', '<cmd>bnext<cr>')

map('<leader>t', "<cmd>Telescope<cr>")
map('<leader>g', "<cmd>Telescope live_grep<cr>")
map('<C-t>', "<cmd>NvimTreeToggle<cr>")
