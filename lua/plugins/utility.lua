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
		opts = {
			mappings = {
				add = '<leader>sa', -- Add surrounding in Normal and Visual modes
				delete = '<leader>sd', -- Delete surrounding
				find = '<leader>sf', -- Find surrounding (to the right)
				find_left = '<leader>sF', -- Find surrounding (to the left)
				highlight = '<leader>sh', -- Highlight surrounding
				replace = '<leader>sr', -- Replace surrounding
				update_n_lines = '<leader>sn', -- Update `n_lines`

				suffix_last = '<leader>l', -- Suffix to search with "prev" method
				suffix_next = '<leader>n', -- Suffix to search with "next" method
			},
		}
	},

	{
		'echasnovski/mini.splitjoin',
		event = "VeryLazy",
		version = false,
		opts = {},
	},
}
