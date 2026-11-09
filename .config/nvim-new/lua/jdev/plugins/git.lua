require("gitsigns").setup({})

-- gitsigns owns the sign column; mini.diff is here only for the inline overlay
require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "", change = "", delete = "" },
  },
})
