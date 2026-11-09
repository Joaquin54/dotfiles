local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  gh("vague-theme/vague.nvim"),
  gh("echasnovski/mini.icons"),
  gh("nvim-lualine/lualine.nvim"),
  gh("b0o/incline.nvim"),
  gh("rachartier/tiny-cmdline.nvim"),
  gh("folke/snacks.nvim"),
  gh("stevearc/oil.nvim"),
  gh("nvim-lua/plenary.nvim"),
  { src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
  gh("echasnovski/mini.pairs"),
  gh("laytan/cloak.nvim"),
  gh("folke/todo-comments.nvim"),
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  gh("neovim/nvim-lspconfig"),
  gh("mason-org/mason.nvim"),
  gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
  { src = gh("Saghen/blink.cmp"), version = vim.version.range("1") },
  { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2") },
  gh("rafamadriz/friendly-snippets"),
  gh("stevearc/conform.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  gh("echasnovski/mini.diff"),
  gh("esmuellert/codediff.nvim"),
  gh("tpope/vim-fugitive"),
  gh("linrongbin16/gitlinker.nvim"),
  gh("lervag/vimtex"),
  { src = gh("chomosuke/typst-preview.nvim"), version = vim.version.range("1") },
  gh("olrtg/nvim-emmet"),
  gh("brenoprata10/nvim-highlight-colors"),
})

require("jdev.plugins.ui")
require("jdev.plugins.editor")
require("jdev.plugins.treesitter")
require("jdev.plugins.lsp")
require("jdev.plugins.completion")
require("jdev.plugins.format")
require("jdev.plugins.git")
require("jdev.plugins.lang")

-- Every plugin keymap lives here, loaded last
require("jdev.plugins.keymaps")
