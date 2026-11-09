require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
  snippets = { preset = "luasnip" },
  -- Tries the prebuilt Rust binary, warns and falls back to Lua if it's absent
  fuzzy = { implementation = "prefer_rust_with_warning" },
  keymap = {
    preset = "none",
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
  },
})
