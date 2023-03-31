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
o.scrolloff = 5
o.pumheight = 15

o.completeopt = "noinsert,menuone,menu"
o.laststatus = 3
o.termguicolors = true
o.signcolumn = "yes"
o.cursorline = true

vim.opt.whichwrap:append "<>[]hl"
g.mapleader = " "
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'onsails/lspkind.nvim'

  use 'phaazon/hop.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'windwp/nvim-autopairs'

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
end)

require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
  indent = { enable = true }
})
require('nvim-autopairs').setup({fast_wrap={}})
require('hop').setup()
require('fidget').setup()
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { {
      function()
        return '▊'
      end,
      color = { fg = "#7e9cd8" }, -- Sets highlighting of component
      padding = { left = 0, right = 1 }, -- We don't need space before this
    }, 'progress', 'location', 'diagnostic', { 'filename', color = { fg = "#d27e99" } }, { function() return '%=' end }, },
    lualine_x = { { 'encoding', color = { fg = '#957fb8' } }, 'diff', { 'branch', color = { fg = "#ffa066" } } },
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
require('telescope').setup({
  defaults = {
    --borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
  },
})

vim.cmd [[colorscheme kanagawa]]
local lsp = require('lspconfig')
local servers = {
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
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for name, settings in pairs(servers) do
  settings = vim.tbl_extend("keep", settings, { on_attach = on_attach, capabilities = capabilities })
  lsp[name].setup(settings)
end
local opts = { noremap = true, silent = true }
map('n', '<C-p>', ':bprev<cr>', opts)
map('n', '<C-n>', ':bnext<cr>', opts)
map('n', '<leader>hw', ':HopWord<cr>', opts)
map('n', '<leader>ha', ':HopAnywhere<cr>', opts)
local telescope = require('telescope.builtin')
map('n', '<leader>ff', telescope.find_files, opts)
map('n', '<leader>dd', telescope.diagnostics, opts)
map('n', '<leader>t', ':Telescope<CR>', opts)
local cmp = require('cmp')
local luasnip = require('luasnip')
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

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 25, ellipsis_char = '…' })(entry, vim_item)
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
    ['<C-b>'] = cmp.mapping.scroll_docs( -4),
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
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
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
