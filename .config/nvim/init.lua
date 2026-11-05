require("tinchodev")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt_local.tabstop = 4       -- Number of spaces a tab counts for
    vim.opt_local.shiftwidth = 4   -- Number of spaces for each indentation level
    vim.opt_local.expandtab = true -- Use spaces instead of tabs
  end,
})
