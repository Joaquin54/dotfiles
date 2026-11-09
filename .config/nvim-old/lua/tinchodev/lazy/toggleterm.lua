return({
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<c-\>]], -- Press Ctrl + \ to toggle
			hide_numbers = true,
			shade_terminals = true,
			direction = "float", -- Options: 'vertical' | 'horizontal' | 'tab' | 'float'
			close_on_exit = true,
		})
	end,
})
