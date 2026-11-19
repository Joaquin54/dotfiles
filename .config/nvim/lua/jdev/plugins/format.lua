local prettier = { "prettierd", "prettier", stop_after_first = true }

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    cs = { "csharpier" },
    javascript = prettier,
    javascriptreact = prettier,
    typescript = prettier,
    typescriptreact = prettier,
    json = prettier,
    css = prettier,
    html = prettier,
    markdown = prettier,
  },
  -- rust and typst have no entry, so the fallback sends them to their language server
  format_on_save = function(bufnr)
    if vim.b[bufnr].disable_autoformat then
      return
    end

    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})
