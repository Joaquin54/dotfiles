local yank = vim.api.nvim_create_augroup("jdev_yank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank,
  callback = function()
    vim.hl.on_yank()
  end,
})

local external = vim.api.nvim_create_augroup("jdev_external_edits", { clear = true })

-- Claude edits files from a tmux pane; reload rather than review a stale buffer
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = external,
  callback = function(args)
    if vim.bo[args.buf].buftype == "" and vim.api.nvim_buf_get_name(args.buf) ~= "" then
      -- checktime is ignored while an autocmd runs; defer it so the buffer actually reloads
      vim.schedule(function()
        vim.cmd("checktime")
      end)
    end
  end,
})
