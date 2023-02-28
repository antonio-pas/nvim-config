local o = vim.o
o.fsync = true
o.hidden = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = 4
o.number = true
o.hlsearch = false
o.relativenumber = true
o.termguicolors = true
o.signcolumn = "yes"
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'overcache/NeoSolarized'
end)
require'nvim-treesitter.configs'.setup{highlight={enable=true}, indent={enable=true}}
vim.cmd[[colorscheme habamax]]
local lsp = require('lspconfig')
local servers = {
    lua_ls = {
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
    }
}
function on_attach(client, bufnr) 
    print("Attached :)")
end
for name, settings in pairs(servers) do
    settings = vim.tbl_extend("keep", settings, { on_attach = on_attach })
    lsp[name].setup(settings)
end

local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    vim.keymap.set(mode, lhs, rhs, opts)
end
local opts = { noremap = true, silent = true }
map('n', '<C-p>', ':bprev<cr>', opts)
map('n', '<C-n>', ':bnext<cr>', opts)
