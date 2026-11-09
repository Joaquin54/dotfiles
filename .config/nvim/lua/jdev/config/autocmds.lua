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

local lsp = vim.api.nvim_create_augroup("jdev_lsp", { clear = true })

-- K, ]d/[d, grn/gra/grr/gri and gO are Neovim defaults and stay untouched
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp,
  callback = function(args)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
    map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
    map("n", "<leader>vca", vim.lsp.buf.code_action, "Code actions")
    map("n", "<leader>vrn", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>vrr", function()
      Snacks.picker.lsp_references()
    end, "Find references")
    map("n", "<leader>vws", function()
      Snacks.picker.lsp_workspace_symbols()
    end, "Workspace symbols")
    map("n", "<leader>vd", vim.diagnostic.open_float, "Show diagnostic for this line")
  end,
})
