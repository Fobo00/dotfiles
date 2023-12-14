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

}
