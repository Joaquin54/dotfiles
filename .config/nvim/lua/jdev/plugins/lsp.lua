-- The default registry's Roslyn (5.12.0-1.26426.8) is older than the build
-- roslyn.nvim needs, and the plugin's cmd passes --daemon-mode, which that
-- build doesn't know. Crashdummyy's `roslyn` tracks the version vscode ships.
require("mason").setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
})

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
    "roslyn",
    "stylua",
    "prettierd",
    "clang-format",
    "ruff",
    "csharpier",
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
  -- Listed to keep this the server inventory, but roslyn.nvim enables it too,
  -- so unlike the others, deleting this line alone does not turn it off
  "roslyn",
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
