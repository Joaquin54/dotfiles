vim.keymap.set("n", "<leader>zz", function()
  Snacks.zen()
end, { desc = "Zen mode" })

vim.keymap.set("n", "<leader>zZ", function()
  Snacks.zen.zoom()
end, { desc = "Zoom current split" })

vim.keymap.set("n", "<leader>nd", function()
  Snacks.notifier.hide()
end, { desc = "Dismiss notifications" })

vim.keymap.set("n", "<leader>pv", function()
  require("oil").open()
end, { desc = "Open file explorer here" })

vim.keymap.set("n", "<leader>pf", function()
  Snacks.picker.files()
end, { desc = "Find files" })

vim.keymap.set("n", "<C-p>", function()
  Snacks.picker.git_files()
end, { desc = "Find git-tracked files" })

vim.keymap.set("n", "<leader>ps", function()
  Snacks.picker.grep()
end, { desc = "Live grep" })

vim.keymap.set("n", "<leader>pws", function()
  Snacks.picker.grep_word()
end, { desc = "Grep word under cursor" })

vim.keymap.set("n", "<leader>pWs", function()
  Snacks.picker.grep({ search = vim.fn.expand("<cWORD>") })
end, { desc = "Grep WORD under cursor" })

vim.keymap.set("n", "<leader>vh", function()
  Snacks.picker.help()
end, { desc = "Search help pages" })

vim.keymap.set("n", "<leader>pb", function()
  Snacks.picker.buffers()
end, { desc = "Pick open buffers" })

vim.keymap.set("n", "<leader>pr", function()
  Snacks.picker.resume()
end, { desc = "Resume last picker" })

vim.keymap.set("n", "<leader>pd", function()
  Snacks.picker.diagnostics()
end, { desc = "List diagnostics" })

-- todo-comments registers no snacks picker source, so its quickfix list feeds the picker
vim.keymap.set("n", "<leader>pt", function()
  vim.cmd("TodoQuickFix")
  Snacks.picker.qflist()
end, { desc = "List TODO comments" })

vim.keymap.set("n", "<leader>pn", function()
  Snacks.picker.notifications()
end, { desc = "Notification history" })

vim.keymap.set("n", "<leader>pk", function()
  Snacks.picker.keymaps()
end, { desc = "Search all keymaps" })

vim.keymap.set("n", "<leader>a", function()
  require("harpoon"):list():add()
end, { desc = "Harpoon: mark current file" })

vim.keymap.set("n", "<leader>h", function()
  local harpoon = require("harpoon")
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: open menu" })

for i = 1, 8 do
  vim.keymap.set("n", "<leader>" .. i, function()
    require("harpoon"):list():select(i)
  end, { desc = "Harpoon: jump to file " .. i })
end

vim.keymap.set("n", "<leader>bd", function()
  Snacks.bufdelete.delete()
end, { desc = "Close current buffer" })

vim.keymap.set("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Close all other buffers" })

vim.keymap.set("n", "]]", function()
  Snacks.words.jump(1)
end, { desc = "Next use of word under cursor" })

vim.keymap.set("n", "[[", function()
  Snacks.words.jump(-1)
end, { desc = "Previous use of word under cursor" })

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next TODO comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous TODO comment" })

vim.keymap.set("n", "<leader>ct", "<cmd>CloakToggle<CR>", { desc = "Toggle cloak" })

vim.keymap.set("n", "<leader>vR", function()
  Snacks.rename.rename_file()
end, { desc = "Rename file and update imports" })

-- lspconfig no longer ships :LspRestart; stopping the clients and reloading the
-- buffer lets vim.lsp.enable attach them again
vim.keymap.set("n", "<leader>lr", function()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    client:stop(true)
  end

  vim.defer_fn(function()
    vim.cmd("edit")
  end, 200)
end, { desc = "Restart LSP" })

vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ lsp_format = "fallback" })
end, { desc = "Format file" })

vim.keymap.set("n", "<leader>F", function()
  vim.b.disable_autoformat = not vim.b.disable_autoformat
  vim.notify("Format on save " .. (vim.b.disable_autoformat and "off" or "on") .. " for this buffer")
end, { desc = "Toggle format-on-save for this buffer" })

vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status (fugitive)" })

vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Open lazygit" })

vim.keymap.set("n", "]c", function()
  require("gitsigns").nav_hunk("next")
end, { desc = "Next changed hunk" })

vim.keymap.set("n", "[c", function()
  require("gitsigns").nav_hunk("prev")
end, { desc = "Previous changed hunk" })

vim.keymap.set("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })

-- stage_hunk toggles: a second press on a staged hunk unstages it
vim.keymap.set("n", "<leader>gh", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage / unstage hunk (approve)" })

vim.keymap.set("n", "<leader>gr", function()
  require("gitsigns").reset_hunk()
end, { desc = "Reset hunk (reject)" })

vim.keymap.set("n", "<leader>gS", function()
  require("gitsigns").stage_buffer()
end, { desc = "Stage whole file" })

vim.keymap.set("n", "<leader>gH", function()
  Snacks.picker.git_diff()
end, { desc = "Pick from all changed hunks" })

vim.keymap.set("n", "<leader>gd", function()
  MiniDiff.toggle_overlay()
end, { desc = "Toggle inline diff overlay" })

vim.keymap.set("n", "<leader>gv", "<cmd>CodeDiff<CR>", { desc = "Side-by-side diff of all changes" })
vim.keymap.set("n", "<leader>gf", "<cmd>CodeDiff history %<CR>", { desc = "History of this file" })
vim.keymap.set("n", "<leader>gF", "<cmd>CodeDiff history<CR>", { desc = "History of the repo" })

vim.keymap.set("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Blame this line" })

vim.keymap.set("n", "<leader>gB", function()
  require("gitsigns").blame()
end, { desc = "Blame whole file" })

vim.keymap.set("n", "<leader>go", "<cmd>Gitsigns show HEAD<CR>", { desc = "Open file as of the last commit" })

vim.keymap.set({ "n", "x" }, "<leader>gl", "<cmd>GitLink<CR>", { desc = "Copy git permalink to line" })

-- Only meaningful while resolving a merge conflict, so they fall through to the
-- gu / gh operators outside diff mode
vim.keymap.set("n", "gu", function()
  return vim.wo.diff and "<cmd>diffget //2<CR>" or "gu"
end, { desc = "Take left side (diff mode)", expr = true })

vim.keymap.set("n", "gh", function()
  return vim.wo.diff and "<cmd>diffget //3<CR>" or "gh"
end, { desc = "Take right side (diff mode)", expr = true })

local fugitive = vim.api.nvim_create_augroup("jdev_fugitive_keys", { clear = true })

-- fugitive has no keymap option, so its buffer-local keys live with this autocmd
vim.api.nvim_create_autocmd("FileType", {
  group = fugitive,
  pattern = "fugitive",
  callback = function(args)
    local opts = { buffer = args.buf }

    vim.keymap.set("n", "<leader>p", function()
      vim.cmd.Git("push")
    end, vim.tbl_extend("force", opts, { desc = "Push" }))

    vim.keymap.set("n", "<leader>P", function()
      vim.cmd.Git({ "pull", "--rebase" })
    end, vim.tbl_extend("force", opts, { desc = "Pull with rebase" }))

    vim.keymap.set(
      "n",
      "<leader>t",
      ":Git push -u origin ",
      vim.tbl_extend("force", opts, { desc = "Start git push -u origin" })
    )
  end,
})

vim.keymap.set({ "n", "x" }, "<leader>ew", function()
  require("nvim-emmet").wrap_with_abbreviation()
end, { desc = "Wrap with Emmet abbreviation" })
