return {

	{
		"akinsho/toggleterm.nvim",
		version = '*',
		opts = {
			shell = vim.g.terminal_emulator
		},
		-- config = function()
		-- 	require("toggleterm").setup {
		-- 		shell = vim.g.terminal_emulator
		-- 	}
		-- end,
		keys = {
			{ "<leader>tt", "<cmd> ToggleTerm size=50 direction=vertical<CR>", desc = "Open Terminal" },
		}
	},

	{
		"OXY2DEV/patterns.nvim",
		lazy = true,
		config = function ()
			local parser_configs = require("nvim-treesitter.parsers").get_parser_configs();

			parser_configs.lua_patterns = {
				install_info = {
					url = "https://github.com/OXY2DEV/tree-sitter-lua_patterns",
					files = { "src/parser.c" },
					branch = "main",
				},
			}
		end,
		cmd = "Patterns",
	},

	{
		enabled = false,
		"gbprod/yanky.nvim",
		opts = {},
		-- config = function()
		-- 	require("yanky").setup {}
		-- end,
		keys = {
			{ "P", "<cmd> YankyRingHistory<CR>", desc = "Open yank history" },
		},
		lazy = false,
	},

	{
		'echasnovski/mini.ai',
		event = "VeryLazy",
		version = "*",
		opts = {},
		-- config = function()
		-- 	require("mini.ai").setup {}
		-- end
	},

	{
		'echasnovski/mini.align',
		version = '*',
		opts = {},
	},

	{
		'echasnovski/mini.comment',
		version = "*",
		opts = {},
		-- config = function()
		-- 	require("mini.comment").setup {}
		-- end
	},

	{
		'echasnovski/mini.sessions',
		version = '*',
		opts = {},
	},

	{
		'echasnovski/mini.surround',
		version = "*",
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
		version = "*",
		opts = {},
	},
}
