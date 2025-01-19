return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			-- words are so great
		},
		init = function()
			vim.g.snacks_animate = false
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
					Snacks.toggle.diagnostics():map("<leader>td")
					Snacks.toggle.line_number():map("<leader>tl")
					Snacks.toggle.treesitter():map("<leader>tT")
					Snacks.toggle.inlay_hints():map("<leader>th")
					Snacks.toggle.dim():map("<leader>tD")
					Snacks.toggle.zen():map("<leader>tz")
				end,
			})
		end,
		keys = {
			{ "<c-F4>", function() Snacks.bufdelete() end, desc = "Close the current buffer" },
			{ "<leader>lc", function () Snacks.lazygit() end, desc = "LazyGit" },
		},
	},
}
