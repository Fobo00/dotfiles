return {

	{
		"akinsho/toggleterm.nvim",
		version = '*',
		config = function()
			require("toggleterm").setup {
				shell = vim.g.terminal_emulator
			}
		end,
		keys = {
			{ "<leader>tt", "<cmd> ToggleTerm size=50 direction=vertical<CR>", desc = "Open Terminal" },
		}
	},

	{
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup {}
		end,
		keys = {
			{ "P", "<Plug>YankyRingHistory", desc = "Open yank history" },
		},
		lazy = false,
	},

	{
		'norcalli/nvim-colorizer.lua',
		event = "BufEnter",
		config = function()
			require("colorizer").setup {}
		end
	},

	{
		'echasnovski/mini.ai',
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.ai").setup {}
		end
	},

	{
		'echasnovski/mini.comment',
		version = false,
		config = function()
			require("mini.comment").setup {}
		end
	},

	{
		'echasnovski/mini.surround',
		version = false,
		opts = {}
	},

	{
		'echasnovski/mini.splitjoin',
		event = "VeryLazy",
		version = false,
		opts = {},
	},
}
