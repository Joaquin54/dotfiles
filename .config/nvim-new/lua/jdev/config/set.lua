local opt = vim.opt

opt.guicursor = ""
opt.cursorline = true
opt.number = true
opt.relativenumber = true

opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Claude edits files from a tmux pane; see the checktime autocmd
opt.autoread = true

opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.splitright = true
opt.splitbelow = true
-- One global statusline for lualine
opt.laststatus = 3
opt.winborder = "rounded"

opt.clipboard = "unnamedplus"

-- 50 fired CursorHold constantly
opt.updatetime = 300
-- Kills the 1-second waits on keys that are prefixes of others
opt.timeoutlen = 500
opt.ttimeoutlen = 0
