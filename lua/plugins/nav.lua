return {

	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"BurntSushi/ripgrep",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd> Telescope live_grep<CR>",   "n" },
			{ "<leader>ff", "<cmd> Telescope find_files<CR>",  "n" },
			{ "<leader>td", "<cmd> Telescope diagnostics<CR>", "n" },
		},
		cmd = "Telescope find_files",
		event = "VeryLazy",
	},

	{
		"kyazdani42/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		version = "nightly",
		config = function()
			require("nvim-tree").setup {
				respect_buf_cwd = false,
				update_focused_file = {
					enable = true,
					update_root = false,
				}
			}
		end,
		keys = {
			{ "<leader>/", ":NvimTreeToggle<CR>", desc = "NvimTree" },
		}
	},

	{
		"asiryk/auto-hlsearch.nvim",
		version = "*",
		config = function()
			require("auto-hlsearch").setup {}
		end
	},

	"LintaoAmons/cd-project.nvim",

}
