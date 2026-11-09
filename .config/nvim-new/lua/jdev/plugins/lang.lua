-- vimtex is Vimscript: these have to be set before its plugin file is sourced
-- zathura (not zathura_simple): synctex forward/inverse search, needs xdotool and pstree
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_automatic = 1
-- Underfull/Overfull/warning noise should not open the quickfix window
vim.g.vimtex_quickfix_ignore_filters = {
  "Underfull",
  "Overfull",
  "Warning",
  ".*warning.*",
}
vim.g.vimtex_quickfix_open_on_warning = 0

require("typst-preview").setup({})
require("nvim-highlight-colors").setup({})
