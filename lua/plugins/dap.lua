return {

	{
		"jay-babu/mason-nvim-dap.nvim",
		requires = "mason.nvim",
		config = function()
			require("mason-nvim-dap").setup {}
		end
	},

	{
		"mfussenegger/nvim-dap",
		-- requires = "rcarriga/nvim-dap-ui",
		keys = {
			{ "<leader>b",   ":lua require'dap'.toggle_breakpoint() <CR>", "n", { silent = true } },
			{ "<leader>dbg", ":lua require'dap'.continue() <CR>",          "n", { silent = true } },
			{ "<leader>dui", ":lua require'dap'.repl.open() <CR>",         "n", { silent = true } },
		},
		config = function()
			local dap = require("dap")

			-- GDB
			--[[dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interp=dap" }
			}]]

			--[[dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end
				}
			}]]
			-- dap.configurations.cpp = dap.configurations.c

			-- CODELLDB
			dap.adapters.codelldb = {
				type = 'server',
				host = 'localhost',
				port = "${port}",
				executable = {
					-- CHANGE THIS to your path!
					command = vim.fn.stdpath("data") .. "/mason/packages\\codelldb\\extension\\adapter\\codelldb.exe",
					args = { "--port", "${port}" },

					-- On windows you may have to uncomment this:
					detached = false,
				}
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = true,
				},
				{
					name = "Attach to process",
					type = "codelldb",
					request = "attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				}
			}
			dap.configurations.c = dap.configurations.cpp
		end
	},

	{
		"rcarriga/nvim-dap-ui",
		requires = "mfussenegger/nvim-dap",
		config = function()
			require("dapui").setup()

			local dap, dapui = require("dap"), require("dapui")

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	}

}
