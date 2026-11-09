require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = false,
  },
  keymaps = {
    ["q"] = { "actions.close", mode = "n" },
  },
})

require("harpoon"):setup({})

require("mini.pairs").setup({})

require("cloak").setup({
  enabled = true,
  cloak_character = "*",
  highlight_group = "Comment",
  patterns = {
    {
      file_pattern = {
        ".env*",
        "wrangler.toml",
        ".dev.vars",
      },
      cloak_pattern = "=.+",
    },
  },
})

require("todo-comments").setup({})
