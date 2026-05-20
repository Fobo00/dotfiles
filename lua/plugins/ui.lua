return {

	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		enabled = false,
		lazy = false,
		build = ":TSUpdate",
	},

	{
		"OXY2DEV/markview.nvim",
		opts = {
			experimental = {
				check_rtp_message = false,
			}
		},
		lazy = false
	},

	{
		"OXY2DEV/helpview.nvim",
		opts = {}
	},

	{
		"norcalli/nvim-colorizer.lua",
		opts = {}
	},

	{
		"EL-MASTOR/bufferlist.nvim",
		lazy = true,
		keys = {
			{ "<leader>b", "<cmd> BufferList<CR>", desc = "Open bufferlist" }
		},
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = "BufferList",
		opts = {},
	},

	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("kanagawa").setup {
				compile = true,
				theme = "dragon",
				functionStyle = { bold = true, italic = true },
			}
		end,
	},

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline-conf")
		end
	},

	{
		'Bekaboo/dropbar.nvim',
		lazy = false,
		keys = {
			{ "<leader><A-m>", "<cmd>lua require('dropbar.api').pick()<cr>" }
		}
	},

	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {
			-- options
		},
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		opts = {
			preset = "powerline",
			options = {
				multilines = { enabled = true },
				break_line = { enabled = true },
			},
		},
		-- keys = {
		-- 	{
		-- 		"<leader>ti",
		-- 		function()
		-- 			require("tiny-inline-diagnostic").toggle()
		-- 		end,
		-- 		desc = "[T]oggle tiny [I]nline diagnostics"
		-- 	}
		-- }
	},

	{
		enabled = false,
		"sontungexpt/sttusline",
		branch = "table_version",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = { "BufEnter" },
		opts = {
			statusline_color = "GruvboxGray",
			-- 0 | 1 | 2 | 3
			-- recommended: 3
			laststatus = 3,
			disabled = {
				filetypes = {
					"NvimTree",
					"lazy",
				},
				buftypes = {
					"terminal",
				},
			},
			components = {
				"mode",
				"filename",
				"git-branch",
				"git-diff",
				"datetime",
				"%=",
				"diagnostics",
				"lsps-formatters",
				"copilot",
				"indent",
				"encoding",
				"pos-cursor",
				"pos-cursor-progress",
			},

		},
	},

	{
		-- Calls `require('slimline').setup({})`
		enabled = true,
		"sschleemilch/slimline.nvim",
		opts = {
			spaces = {
				components = "─",
				left = "─",
				right = "─",
			},
			sep = {
				hide = {
					first = true,
					last = true,
				},
				left = "",
				right = "",
			},
		},
		init = function()
			vim.opt.fillchars = {
				stl = "─",
			}
		end
	},
}
