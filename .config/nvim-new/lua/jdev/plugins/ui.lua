local utils = require("jdev.utils")

require("vim._core.ui2").enable({})
-- The cmdline is a floating box now, so nothing needs a reserved line
vim.o.cmdheight = 0

local colors = vim.api.nvim_create_augroup("jdev_colorscheme", { clear = true })

local amber = "#c9a84c"

-- Reapplied on every scheme change so the overrides survive a reload.
-- Deliberately does not force a scheme; that broke :colorscheme in the old config.
local function overrides()
  for _, group in ipairs({ "Normal", "NormalFloat", "SignColumn", "LineNr", "EndOfBuffer", "CursorLine" }) do
    vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = group }), { bg = "NONE" }))
  end

  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = amber, bold = true })
  vim.api.nvim_set_hl(0, "CursorLineSign", { fg = amber })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = colors,
  callback = overrides,
})

require("vague").setup({})
vim.cmd("colorscheme vague")

require("mini.icons").setup({})
-- Stands in for nvim-web-devicons, so no second icon plugin
MiniIcons.mock_nvim_web_devicons()

require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
})

require("incline").setup({
  render = function(props)
    local path = utils.relative_path(props.buf) or "[No Name]"
    local icon, hl = MiniIcons.get("file", path)

    return {
      { icon .. " ", group = hl },
      path,
      vim.bo[props.buf].modified and " [+]" or "",
    }
  end,
})

require("snacks").setup({
  notifier = { enabled = true },
  indent = { enabled = true },
  words = { enabled = true },
})
