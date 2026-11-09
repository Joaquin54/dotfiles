vim.api.nvim_create_user_command("TypstWatch", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("No file to preview", vim.log.levels.WARN)
    return
  end

  -- Detached, so it keeps watching after Neovim closes
  vim.fn.jobstart({ "typst", "watch", file, "--open", "zathura" }, { detach = true })
  vim.notify("Typst watch started (Zathura)")
end, { desc = "Compile the current Typst file and open it in Zathura" })
