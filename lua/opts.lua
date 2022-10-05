local o = vim.opt
local g = vim.g
g.mapleader = ' '
o.number = true
o.relativenumber = true

o.smartindent = true
o.smarttab = true
o.smartcase = true
o.ignorecase = true

o.softtabstop = 2
o.tabstop = 2
o.shiftwidth = 2
o.hlsearch = false
o.incsearch = true
o.expandtab = true
o.hidden = true
o.wrap = false
o.completeopt = 'longest,noselect,menu,menuone'

vim.cmd('colorscheme habamax')
