-- harpoon.lua
return {
  'ThePrimeagen/harpoon',
  config = function()
    require('harpoon').setup {}

-- Keybinds
    vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>1', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>2', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>3', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>4', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>5', '<cmd>lua require("harpoon.ui").nav_file(5)<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>6', '<cmd>lua require("harpoon.ui").nav_file(6)<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>7', '<cmd>lua require("harpoon.ui").nav_file(7)<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>8', '<cmd>lua require("harpoon.ui").nav_file(8)<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>lua require("harpoon.mark").clear_all()<CR>', { noremap = true, silent = true })
  end
}
