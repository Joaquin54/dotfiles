-- Parser names, which differ from the filetypes below: vimdoc -> help,
-- bash -> sh, tsx -> typescriptreact, c_sharp -> cs, and markdown_inline has no filetype
-- of its own (markdown's parser injects it).
local parsers = {
  "bash",
  "c",
  "c_sharp",
  "cpp",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "rust",
  "tsx",
  "typescript",
  "typst",
  "vim",
  "vimdoc",
}

-- No-op once the parsers are on disk
require("nvim-treesitter").install(parsers)

-- Folds are computed but open; I close them deliberately, never on open
vim.opt.foldlevel = 99

local group = vim.api.nvim_create_augroup("jdev_treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = {
    "lua",
    "vim",
    "help",
    "query",
    "markdown",
    "python",
    "c",
    "cpp",
    "cs",
    "rust",
    "javascript",
    "typescript",
    "typescriptreact",
    "html",
    "css",
    "json",
    "sh",
    "typst",
  },
  callback = function()
    vim.treesitter.start()
    -- Experimental, per the plugin's README; the quoting is exact
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.wo[0][0].foldmethod = "expr"
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})
