require("mason").setup({})

-- Mason package names, not lspconfig server names
require("mason-tool-installer").setup({
  ensure_installed = {
    "lua-language-server",
    "basedpyright",
    "typescript-language-server",
    "tailwindcss-language-server",
    "css-lsp",
    "html-lsp",
    "clangd",
    "rust-analyzer",
    "tinymist",
    "stylua",
    "prettierd",
    "clang-format",
    "ruff",
  },
  auto_update = false,
  run_on_start = true,
})

-- Leaving a server off this list turns it off
vim.lsp.enable({
  "lua_ls",
  "basedpyright",
  "ts_ls",
  "tailwindcss",
  "cssls",
  "html",
  "clangd",
  "rust_analyzer",
  "tinymist",
})

vim.diagnostic.config({
  virtual_text = { prefix = "●", source = "if_many" },
  severity_sort = true,
  update_in_insert = false,
  -- Border comes from the global winborder
  float = {
    focusable = false,
    style = "minimal",
    source = "if_many",
    header = "",
    prefix = "",
  },
})
