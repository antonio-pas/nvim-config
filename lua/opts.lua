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
o.expandtab = true

o.hlsearch = false
o.incsearch = true

o.hidden = true
o.wrap = false

o.backup = true
o.backupdir = "/home/antonio/nvimtmp/"
o.fsync = true
o.completeopt = 'noinsert,noselect,menuone'
o.termguicolors = true

g.netrw_winsize = 30
g.netrw_liststyle = 3
g.netrw_banner = 0

vim.cmd('colorscheme gruvbox')
