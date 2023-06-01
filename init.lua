local o = vim.o
local g = vim.g
o.fsync = true

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true

o.number = true
o.numberwidth = 2
o.relativenumber = true

o.hlsearch = false
o.ignorecase = true
o.smartcase = true
o.showmode = false
o.hidden = true
o.wrap = false
o.scrolloff = 10
o.pumheight = 15

o.completeopt = "noinsert,menuone,menu"
o.laststatus = 3
o.termguicolors = true
o.signcolumn = "yes"
o.cursorline = true

vim.opt.whichwrap:append "<>[]hl"
g.mapleader = " "
--vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "setlocal nonu" })
vim.cmd [[autocmd TermOpen * setlocal nonu|setlocal norelativenumber]]
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'onsails/lspkind.nvim'
  use 'akinsho/bufferline.nvim'
  use 'numToStr/Comment.nvim'

  use 'phaazon/hop.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
  use 'karb94/neoscroll.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'b0o/SchemaStore.nvim'
  use 'j-hui/fidget.nvim'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use 'rebelot/kanagawa.nvim'
  use 'navarasu/onedark.nvim'
end)
require('onedark').setup({
  highlights = {
    ["@constructor"] = { fmt = "none" },
    ["@text.title"] = { fmt = "none" }
  }
})
require('onedark').load()
require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true }
})
require('nvim-autopairs').setup({ fast_wrap = {} })
require('hop').setup()
require('neoscroll').setup()
require('fidget').setup()
require('bufferline').setup()
require('lsp_lines').setup()
require('Comment').setup()
require('lualine').setup {
  options = {
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    globalstatus = true,
  },
}
require('telescope').setup({})

local lsp = require('lspconfig')
local servers = {
  svelte = {},
  cssls = {},
  eslint = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  rust_analyzer = {
    settings = {
          ['rust-analyzer'] = {
        signatureInfo = {
          detail = "parameters"
        }
      }
    },
    cmd = { "rustup", "run", "stable", "rust-analyzer" }
  },
  tsserver = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true }
      },
    },
  },
}
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local function on_attach(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  map('n', '<leader>hh', vim.lsp.buf.hover, opts)
  map('n', '<leader>do', vim.diagnostic.open_float, opts)
  map('n', '<leader>gd', vim.lsp.buf.definition, opts)
  map('n', '<leader>gD', vim.lsp.buf.declaration, opts)
  map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  map('n', '<leader>fm', vim.lsp.buf.format, opts)
  map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
end

local opts = { noremap = true, silent = true }
local telescope = require('telescope.builtin')
map('n', '<C-p>', ':bprev<cr>', opts)
map('n', '<C-n>', ':bnext<cr>', opts)
map('n', '<leader>hw', ':HopWord<cr>', opts)
map('n', '<leader>ha', ':HopAnywhere<cr>', opts)
map('n', '<leader>ff', telescope.find_files, opts)
map('n', '<leader>dd', telescope.diagnostics, opts)
map('n', '<leader>t', ':Telescope<CR>', opts)
map('t', '<esc>', '<C-\\><C-n>', opts)


local capabilities = require('cmp_nvim_lsp').default_capabilities()
for name, settings in pairs(servers) do
  settings = vim.tbl_extend("keep", settings, { on_attach = on_attach, capabilities = capabilities })
  lsp[name].setup(settings)
end
local function border(hl_name)
  return {
    { "╭", hl_name }, -- ┌
    { "─", hl_name },
    { "╮", hl_name }, -- ┐
    { "│", hl_name },
    { "╯", hl_name }, -- ┘
    { "─", hl_name },
    { "╰", hl_name }, -- └
    { "│", hl_name },
  }
end
local lspkind = require('lspkind')
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 25, ellipsis_char = '…' })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = strings[1] or ""
      kind.menu = strings[2] or ""

      return kind
    end,
  },
  window = {
    completion = {
      border = border "Comment",
      winhighlight = "Normal:Normal,CursorLine:CursorLine",
      scrollbar = ""
    },
    documentation = {
      border = border "Comment",
      winhighlight = "Normal:Normal",
      scrollbar = ""
    },
  },
  mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    --{ name = 'buffer' },
    --{ name = 'luasnip' },
  })
})
