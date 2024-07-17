local local_plugins = require('tinchodev.lazy.local')
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    require('tinchodev.lazy.harpoon'),
    local_plugins,
    spec = "tinchodev.lazy",
    change_detection = { notify = false },
})

local colors = require('tinchodev.lazy.colors')
--vim.api.nvim_set_keymap('n', '<leader>tb', ':lua ColorMyPencils()<CR>', { noremap = true, silent = true })

ColorMyPencils()
