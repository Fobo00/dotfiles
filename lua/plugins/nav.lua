return {


	{
		"nvim-telescope/telescope.nvim",
		enabled = true,
		version = "*",
		dependencies = {
			"BurntSushi/ripgrep",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd> Telescope live_grep<CR>",   "n" },
			{
				"<leader>mg",
				function()
					require("multigrep").multigrep()
				end,
				desc = "[M]ulti [G]rep"
			},
			{ "<leader>ff", "<cmd> Telescope find_files<CR>",  "n" },
			{ "<leader>fd", "<cmd> Telescope diagnostics<CR>", "n" },
			{ "<leader>fp", function()
				require('telescope.builtin').find_files {
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
				}
			end, { desc = "[F]ind in [P]ackages" } }
		},
		cmd = "Telescope find_files",
		event = "VeryLazy",
	},

	{
		"hrsh7th/nvim-deck",
		-- enabled = not vim.uv.os_uname().sysname == "Windows_NT",
		lazy = true,
		config = function()
			local deck = require("deck")
			-- Apply pre-defined easy settings.
			-- For manual configuration, refer to the code in `deck/easy.lua`.
			require('deck.easy').setup()

			-- Set up buffer-specific key mappings for nvim-deck.
			vim.api.nvim_create_autocmd('User', {
				pattern = 'DeckStart',
				callback = function(e)
					local ctx = e.data.ctx --[[@as deck.Context]]
					ctx.keymap('n', '<Esc>', function()
						ctx.set_preview_mode(false)
					end)
					ctx.keymap('n', '<Tab>', deck.action_mapping('choose_action'))
					ctx.keymap('n', '<C-l>', deck.action_mapping('refresh'))
					ctx.keymap('n', 'i', deck.action_mapping('prompt'))
					ctx.keymap('n', 'a', deck.action_mapping('prompt'))
					ctx.keymap('n', '@', deck.action_mapping('toggle_select'))
					ctx.keymap('n', '*', deck.action_mapping('toggle_select_all'))
					ctx.keymap('n', 'p', deck.action_mapping('toggle_preview_mode'))
					ctx.keymap('n', 'd', deck.action_mapping('delete'))
					ctx.keymap('n', '<CR>', deck.action_mapping('default'))
					ctx.keymap('n', 'o', deck.action_mapping('open'))
					ctx.keymap('n', 'O', deck.action_mapping('open_keep'))
					ctx.keymap('n', 's', deck.action_mapping('open_split'))
					ctx.keymap('n', 'v', deck.action_mapping('open_vsplit'))
					ctx.keymap('n', 'N', deck.action_mapping('create'))
					ctx.keymap('n', '<C-u>', deck.action_mapping('scroll_preview_up'))
					ctx.keymap('n', '<C-d>', deck.action_mapping('scroll_preview_down'))

					-- If you want to start the filter by default, call ctx.prompt() here
					ctx.prompt()
				end
			})
			-- deck.setup({ })
		end,
		keys = {
			-- { "<leader>ff", "<cmd> Deck files<CR>", desc = 'Show recent files, buffers, and more' },
			-- { "<leader>gr", "<cmd> Deck grep<CR>", desc = 'Start grep search'},
			-- { "<leader>hg", "<cmd> Deck helpgrep<CR>", desc = 'Live grep all help tags' },
		},
		-- cmd = { "Deck files", "Deck grep", "Deck helpgrep" },
	},

	-- {
	-- 	'stevearc/oil.nvim',
	-- 	---@module 'oil'
	-- 	---@type oil.SetupOpts
	-- 	opts = {
	-- 		-- columns = {
	-- 		-- 	"icons",
	-- 		-- 	"size",
	-- 		-- },
	-- 		delete_to_trash = true,
	-- 	},
	-- 	-- Optional dependencies
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	-- 	keys = {
	-- 		-- { "<leader>/", ":Oil<CR>", desc = "Oil" },
	-- 	}
	-- },

	{
		'echasnovski/mini.files',
		version = '*',
		opts = {
			options = {
				permanent_delete = false,
				use_as_default_explorer = false,
			},
			windows = {
				preview = true,
			}
		},
		keys = {
			{
				"<leader>/",
				function()
					MiniFiles.open()
				end,
				desc = "Open MiniFiles"
			}
		},
	},

	{
		enabled = false,
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

	-- "LintaoAmons/cd-project.nvim",

}
