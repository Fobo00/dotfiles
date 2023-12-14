vim.g.mapleader = " "
vim.g.maplocalleader = " "
return {

	{
		enabled = false,
		"lewis6991/impatient.nvim", -- Fast
		setup = function()
			require("impatient")
		end,
	},

	----------------------------------------Utility---------------------------------------------------


	{
		enabled = false,
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		config = function()
			require("hardtime").setup()
		end,
	},


	------------------------- Graphics ---------------------------------------------------------------
	{
		enabled = false,
		"chadcat7/prism",
		lazy = false,
		config = function()
			require("prism"):setup({
				customSchemes = {
					-- Add any number of schemes here
					{
						name = "serenade",
						background = "#23282b",
						foreground = "#cde5c3",
						cursorline = "#272b2f",
						comment = "#767b82",
						darker = "#1e2124",
						cursor = "#bfddb2",
						black = "#23282b", -- useful when background is transparent
						color0 = "#2E3338",
						color1 = "#d76e6e",
						color2 = "#ACB765",
						color3 = "#e5a46b",
						color4 = "#82abbc",
						color5 = "#d39bb6",
						color6 = "#87c095",
						color7 = "#bfddb2",
						color8 = "#373D41",
						color9 = "#d76e6e",
						color10 = "#ACB765",
						color11 = "#e5a46b",
						color12 = "#82abbc",
						color13 = "#d39bb6",
						color14 = "#87c095",
						color15 = "#cfe0c7",
					},
				},
				currentTheme = "kanagawa-dragon",
				-- currentTheme = "onedarker",
				customFiles = vim.fn.stdpath "config" .. "/lua/hls",
				transparent = false,
				reload = {}, -- modules to be reloaded everytime theme is set
			})
		end
	},

	-- SLOW 70ms
	{
		enabled = false,
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("lualine-conf")
		end,
		event = "VeryLazy",
	},
	-- Alternative
	{
		enabled = false,
		"famiu/feline.nvim",
		config = function()
			require("feline").setup {}
		end
	},

	{
		enabled = false,
		"windwp/windline.nvim",
		config = function()
			-- require('wlsample.vscode')
			require('wlsample.evil_line')
			require("windline-conf")
		end,
	},

}
