vim.keymap.set("n", "<leader>zz", function()
  Snacks.zen()
end, { desc = "Zen mode" })

vim.keymap.set("n", "<leader>zZ", function()
  Snacks.zen.zoom()
end, { desc = "Zoom current split" })

vim.keymap.set("n", "<leader>nd", function()
  Snacks.notifier.hide()
end, { desc = "Dismiss notifications" })
