-- Enhanced transparency function with more comprehensive overrides
function ColorMyPencils(color)
	color = color or "vague"
	vim.cmd.colorscheme(color)

	-- Apply transparency to all relevant highlight groups
	vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE", ctermbg = "NONE" })
	vim.api.nvim_set_hl(0, "Folded", { bg = "NONE", ctermbg = "NONE" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", ctermbg = "NONE" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE", ctermbg = "NONE" })

	-- Optional: Make floating windows slightly visible (comment if you want complete transparency)
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1a1b26", blend = 90 })
end

-- Setup global Neovim transparency
vim.g.neovide_transparency = 0.8
vim.opt.termguicolors = true
vim.opt.background = "dark"

return {
	{
		"blazkowolf/gruber-darker.nvim",
	},
	{
		"Mofiqul/vscode.nvim",
	},
	{
		"erikbackman/brightburn.vim",
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Ensure it loads early
		config = function()
			require("tokyonight").setup({
				style = "moon",
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					functions = {},
					variables = {},
					sidebars = "transparent",
					floats = "transparent",
				},
				-- dim_inactive = false,
				-- lualine_bold = true,
				-- on_colors = function(colors)
				--     -- Optional: Adjust specific colors if needed
				--     -- colors.bg = "NONE"
				--     -- colors.bg_dark = "NONE"
				-- end,
				on_highlights = function(highlights, colors)
					-- Force all backgrounds to be transparent
					highlights.Normal = { bg = "NONE" }
					highlights.NormalFloat = { bg = "NONE" }
					highlights.SignColumn = { bg = "NONE" }
					highlights.LineNr = { bg = "NONE" }
				end,
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true,
				contrast = "",
				palette_overrides = {},
				overrides = {
					-- Force transparent backgrounds on important elements
					Normal = { bg = "NONE" },
					NormalFloat = { bg = "NONE" },
					SignColumn = { bg = "NONE" },
					LineNr = { bg = "NONE" },
				},
				dim_inactive = false,
				transparent_mode = true,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000, -- Ensure it loads early
		config = function()
			require("rose-pine").setup({
				variant = "moon",
				dark_variant = "moon",
				disable_background = true,
				disable_float_background = true,
				disable_italics = true,
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
				highlight_groups = {
					-- Explicitly set backgrounds to NONE for key highlight groups
					Normal = { bg = "NONE" },
					NormalFloat = { bg = "NONE" },
					SignColumn = { bg = "NONE" },
					LineNr = { bg = "NONE" },
				},
			})

			-- Apply your global transparency function at the end
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					ColorMyPencils()
				end,
			})

			-- Default to rose-pine-moon
			ColorMyPencils("rose-pine-moon")
		end,
	},
	{
		"vague-theme/vague.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vague").setup({})
			vim.cmd("colorscheme vague")

			-- Enable cursor line
			vim.opt.cursorline = true

			-- Set the cursor line text to golden/amber color
			vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#c9a84c", bold = true })
			vim.api.nvim_set_hl(0, "CursorLineSign", { fg = "#c9a84c" })
		end,
	},
}
