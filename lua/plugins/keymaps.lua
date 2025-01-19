return {
	{
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				-- https://github.com/folke/which-key.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
				spec = {
					{ "<leader>t", group = "[T]oggle" },
					{ "<leader>s", group = "[S]urround" },
					{ "<leader>c", group = "[C]ode" },
					{ "<leader>d", group = "[D]ebug" },
					{ "<leader>w", group = "[W]orkspace" },
				}
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
				{
					"<leader>g?",
					function()
						require("which-key").show({ global = true })
					end,
					desc = "Global Keymaps (which-key)",
				},
				{
					"<leader><c-w>",
					function ()
						require("which-key").show({ loop = true })
					end,
					desc = "Show which-key in hydra mode"
				},
			},
			dependencies = "nvim-tree/nvim-web-devicons",
		}
	}
}
