local o = vim.o
local g = vim.g

-- tabs
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true

-- number lines
o.number = true
o.numberwidth = 2
o.relativenumber = true

-- behavior changes
o.hlsearch = false
o.ignorecase = true
o.smartcase = true
o.hidden = true
o.wrap = false
o.scrolloff = 10
o.pumheight = 15

-- ui changes
o.completeopt = "noinsert,menuone,menu"
o.laststatus = 3
o.showmode = false
o.signcolumn = "yes"
o.cursorline = true
o.termguicolors = true

-- other
o.fsync = true
vim.opt.whichwrap:append("<>[]hl")
g.mapleader = " "

-- disable line numbers in terminals
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "setlocal nonu|setlocal norelativenumber" })
