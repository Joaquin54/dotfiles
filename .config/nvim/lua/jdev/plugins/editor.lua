require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = false,
    -- Replaces oil's default, which is the leading-dot check alone. Unity's
    -- .meta sidecars stay hidden but `g.` still reveals them, so a .cs can be
    -- renamed together with its meta and keep its GUID
    is_hidden_file = function(name)
      return vim.startswith(name, ".") or name:match("%.meta$") ~= nil
    end,
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
