return {
  taplo = {},
  tsserver = {},
  ccls = {},
  emmet_ls = {},
  html = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        server = {
          path = "/home/antonio/.rustup/toolchains/nightly-aarch64-unknown-linux-gnu/bin/rust-analyzer"
        }
      }
    },
  },
  sumneko_lua = {
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
  glslls = {},
  jsonls = {},
  svelte = {},
  cssls = {}
}
