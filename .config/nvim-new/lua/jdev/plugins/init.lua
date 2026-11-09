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
})

require("jdev.plugins.ui")

-- Every plugin keymap lives here, loaded last
require("jdev.plugins.keymaps")
