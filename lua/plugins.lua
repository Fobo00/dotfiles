local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy_status, lazy = pcall(require, "lazy")
if not lazy_status then
	return
end


vim.g.mapleader = " "
vim.g.maplocalleader = " "
lazy.setup({

	{
		enabled = false,
		"lewis6991/impatient.nvim", -- Fast
		setup = function()
			require("impatient")
		end,
	},

	-------------------------------------------Completion-------------------------------------

	{
		"folke/neodev.nvim",
		lazy = true,
		event = "BufEnter",
		ft = "lua",
		config = function()
			require("neodev").setup {}
		end,
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
			"L3MON4D3/LuaSnip", -- snippet engine
			-- "rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
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
		},
	},

	---------------------------------------Rust----------------------------------------
	{
		enabled = true,
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
			"nvim-lspconfig",
		},
		config = function()
			require("rust-tools").setup({
				server = {
					on_attach = require("LSP.settings").rust_on_attach
				},
				tools = {
					executor = require("rust-tools.executors").toggleterm,
				}
			})
		end,
	},

	{
		enabled = false,
		'vxpm/ferris.nvim',
		opts = {
			-- your options here
		}
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = "MasonUpdate",
		dependencies = "williamboman/mason-lspconfig.nvim",
	},

	----------------------------------------Utility---------------------------------------------------

	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"BurntSushi/ripgrep",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd> Telescope live_grep<CR>",  "n" },
			{ "<leader>ff", "<cmd> Telescope find_files<CR>", "n" },
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
		"asiryk/auto-hlsearch.nvim",
		version = "*",
		config = function()
			require("auto-hlsearch").setup {}
		end
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
		"ErichDonGubler/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
		keys = {
			{ "<leader>R", ":lua require('lsp_lines').toggle()<CR>", desc = "toggle lsp_lines instead of vim diagnostic" },
		},
	},


	{
		enabled = false,
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		config = function()
			require("hardtime").setup()
		end,
	},

	{
		'norcalli/nvim-colorizer.lua',
		event = "BufEnter",
		config = function()
			require("colorizer").setup {}
		end
	},


	------------------------- Graphics ---------------------------------------------------------------
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup {
				compile = true,
				theme = "dragon",
				colors = require("kan-colors"),
				functionStyle = { bold = true, italic = true },
			}
			require("kanagawa").load("dragon")
		end
	},

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

	{
		-- enabled = false,
		'goolord/alpha-nvim',
		event = "VimEnter",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require("screen")
		end
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
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

	{
		"sontungexpt/sttusline",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = { "BufEnter" },
		config = function(_, opts)
			require("sttusline-conf.components")
			require("sttusline").setup {
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
			}
		end,
	},

	{
		"folke/noice.nvim",
		enabled = false,
		config = function()
			require("noice").setup({
				-- add any options here
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					signature = {
						enabled = false,
						auto_open = {
							enabled = true,
							trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
							luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
							throttle = 50, -- Debounce lsp signature help request by 50ms
						},
						view = nil, -- when nil, use defaults from documentation
						opts = {}, -- merged with defaults from documentation
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

})
