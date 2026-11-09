local utils = require("jdev.utils")

vim.keymap.set("n", "<leader>nf", ":e %:h/", { desc = "New file in this file's folder" })

vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer", silent = true })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location-list item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location-list item" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down, centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up, centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result, centered" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines, cursor stays put" })
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over selection, keep clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>d", [["_d]], { desc = "Delete without copying" })

vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor in file" }
)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make this file executable", silent = true })

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Escape" })
vim.keymap.set("n", "Q", "<Nop>", { desc = "Disabled" })
vim.keymap.set("n", "ZR", "<cmd>restart<CR>", { desc = "Restart Neovim, keeping windows and buffers" })

vim.keymap.set("n", "<leader>yf", utils.yank_file_line, { desc = "Copy relative path with line number" })
vim.keymap.set("n", "<leader>yp", utils.yank_abs_path, { desc = "Copy absolute path" })
vim.keymap.set("x", "<leader>yc", utils.yank_code_block, { desc = "Copy selection as Markdown code block" })
