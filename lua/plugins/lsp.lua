return {

	{
		"folke/neodev.nvim",
		dependencies = {
			"nathom/filetype.nvim",
			"nvim-lua/plenary.nvim",
		},
		--[[opts = {
			library = {
				enabled = true,
				runtime = true,
				types = true,
				plugins = true,
			},
			override = function(root_dir, library)
				library.enabled = true
				library.plugins = true
			end,
			setup_jsonls = true,
			lspconfig = true,
			pathStrict = false,
		},]]
		config = function()
			require("neodev").setup {
				override = function(root_dir, library)
					library.enabled = true
					library.plugins = true
				end,
				-- lspconfig = true,
				pathStrict = true,
			}
		end
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
			"hrsh7th/cmp-path", -- path completions
			{ "garymjr/nvim-snippets", opts = { friendly_snippets = true, create_cmp_source = true },
				dependencies = "rafamadriz/friendly-snippets", },
			"nvim-autopairs",
			"nvim-lspconfig",
			-- { "saecki/crates.nvim", dependencies = "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("cmp-conf")
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end,
		dependencies = { "boltlessengineer/smart-tab.nvim", config = function() require("smart-tab").setup {} end }
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		event = "BufEnter",
		config = function()
			require("LSP")
		end,
		dependencies = {
			{ "simrat39/inlay-hints.nvim", config = function() require("inlay-hints").setup {} end },
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"https://git.sr.ht/~p00f/clangd_extensions.nvim"
		},
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = "MasonUpdate",
		dependencies = { "williamboman/mason-lspconfig.nvim", "mason-nvim-dap.nvim" },
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
