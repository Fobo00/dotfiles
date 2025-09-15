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
			bigfile      = { enabled = true },
			dashboard    = {
				enabled  = true,
				sections = {
					{ section = "header" },
					{ section = "keys",   gap = 1, padding = 1 },
					{
						action = ":lua MiniSessions.select()",
						key = "S",
						desc = " Select Session",
					},
					function()
						local in_git = Snacks.git.get_root() ~= nil
						local pane_number = 1
						if in_git then
							pane_number = 2
						end
						return {
							{
								enabled = in_git,
								pane    = pane_number,
								section = "terminal",
								icon    = " ",
								title   = "Git Status",
								cmd     = "git --no-pager diff --stat -B -M -C",
								height  = 10,
								padding = 1,
								indent  = 3,
							},
						}
					end,
					{ section = "startup" },
				},
			},
			indent       = { enabled = true },
			input        = { enabled = true },
			notifier     = { enabled = true },
			quickfile    = { enabled = true },
			scroll       = { enabled = true },
			statuscolumn = { enabled = true },
			words        = { enabled = true },
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
					Snacks.toggle.zen():map("<leader>tz")
					Snacks.toggle.dim():map("<leader>tD")

					local tiny_inline_diagnostics_enabled = true
					Snacks.toggle.new({
						name = "Tiny Inline Diagnostics",
						id = "tiny_inline_diagnostics",
						get = function ()
							return tiny_inline_diagnostics_enabled
						end,
						set = function (state)
							if state then
								require("tiny-inline-diagnostic").enable()
								tiny_inline_diagnostics_enabled = true
							else
								require("tiny-inline-diagnostic").disable()
								tiny_inline_diagnostics_enabled = false
							end
						end,
					}):map("<leader>ti")
					local hardtime_enabled = false
					Snacks.toggle.new({
						name = "HardTime.nvim",
						id = "hardtime_nvim",
						get = function()
							return hardtime_enabled
						end,
						set = function (state)
							require("hardtime").toggle()
							hardtime_enabled = not hardtime_enabled
						end
					}):map("<leader>tH")
				end,
			})
		end,
		keys = {
			{ "<c-F4>",     function() Snacks.bufdelete() end, desc = "Close the current buffer" },
			{ "<leader>lc", function() Snacks.lazygit() end,   desc = "LazyGit" },
		},
	},
}
