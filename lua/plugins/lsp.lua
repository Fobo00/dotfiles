return {

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		---@alias lazydev.Library {path:string, words:string[], mods:string[]}
		---@alias lazydev.Library.spec string|{path:string, words?:string[], mods?:string[]}
		---@class lazydev.Config
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				"lazy.nvim",
			},
		},
	},

	-- CMP Plugins
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline", -- cmdline completions
			"hrsh7th/cmp-nvim-lua",
			"micangl/cmp-vimtex",
			"hrsh7th/cmp-path", -- path completions
			{
				"garymjr/nvim-snippets",
				opts = { friendly_snippets = true, create_cmp_source = true },
				dependencies = "rafamadriz/friendly-snippets",
			},
			-- "nvim-autopairs",
			'echasnovski/mini.pairs',
			"nvim-lspconfig",
			-- { "saecki/crates.nvim", dependencies = "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("cmp-conf")
		end,
	},

	{
		enabled = false,
		"windwp/nvim-autopairs",
		opts = {},
	},

	{
		'echasnovski/mini.pairs',
		version = false,
		opts = {},
	},

	-- LSP
	{
		-- enabled = false,
		"neovim/nvim-lspconfig",
		event = "BufEnter",
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				rust = "html",
			},
		},
		config = function()
			require("LSP")
		end,
		dependencies = {
			-- { "simrat39/inlay-hints.nvim", config = function() require("inlay-hints").setup {} end },
			"williamboman/mason-lspconfig.nvim",
			"mason.nvim",
			"https://git.sr.ht/~p00f/clangd_extensions.nvim"
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			"williamboman/mason.nvim",
		}
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		}
	},

	{
		"ErichDonGubler/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
		keys = {
			{ "<leader>R", ":lua require('lsp_lines').toggle()<CR>", desc = "toggle lsp_lines instead of vim diagnostic" },
		},
	},

}
