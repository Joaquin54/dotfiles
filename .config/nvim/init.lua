vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("jdev.config.set")
require("jdev.config.remap")
require("jdev.config.autocmds")
require("jdev.config.commands")

require("jdev.plugins")
