return {

	---------------------------------------Rust----------------------------------------
	{
		'mrcjkb/rustaceanvim',
		version = '^3', -- Recommended,
		ft = { 'rust' },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(_, bufnr)
						-- Enable completion triggered by <c-x><c-o>
						vim.g.mapleader = " "
						vim.g.maplocalleader = " "
						vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


						-- Mappings.
						-- See `:help vim.lsp.*` for documentation on any of the below functions
						local bufopts = { noremap = true, silent = true, buffer = bufnr }
						vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
						vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
						vim.keymap.set('n', 'K', ":RustLsp hover actions<CR>", bufopts)
						vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
						vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
						vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
						vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
						vim.keymap.set('n', '<leader>wl', function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end, bufopts)
						vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
						vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
						vim.keymap.set('n', '<leader>ca', ":RustLsp codeAction<CR>", bufopts)
						vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
						--  vim.keymap.set('n', '<leader>fo', vim.lsp.buf.formatting, bufopts)
						vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, bufopts)
						vim.keymap.set('n', '<leader>dbg', vim.cmd.RustLsp { 'debuggables' }, bufopts)
					end -- on_attach
				},
			}
		end
	},

	{
		enabled = false,
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
			"nvim-lspconfig",
		},
		config = function()
			local extension_path = vim.fn.stdpath("data") .. "\\mason\\packages\\codelldb\\extension\\"
			local codelldb_path = extension_path .. "adapter\\codelldb.exe"
			local liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"




			local opts = {
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(
						codelldb_path, liblldb_path
					)
				},
				server = {
					on_attach = function(_, bufnr)
						-- Enable completion triggered by <c-x><c-o>
						vim.g.mapleader = " "
						vim.g.maplocalleader = " "
						vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

						local rt = require("rust-tools")


						-- Mappings.
						-- See `:help vim.lsp.*` for documentation on any of the below functions
						local bufopts = { noremap = true, silent = true, buffer = bufnr }
						vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
						vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
						vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, bufopts)
						vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
						vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
						vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
						vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
						vim.keymap.set('n', '<leader>wl', function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end, bufopts)
						vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
						vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
						vim.keymap.set('n', '<leader>ca', ":RustCodeAction<CR>", bufopts)
						vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
						--  vim.keymap.set('n', '<leader>fo', vim.lsp.buf.formatting, bufopts)
						vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, bufopts)
						vim.keymap.set('n', '<leader>dbg', ":RustDebuggables<CR>", bufopts)
					end -- on_attach

				},
				tools = {
					executor = require("rust-tools.executors").toggleterm,
				},
			}
			require("rust-tools").setup(opts)
		end,
	},

	{
		enabled = false,
		'vxpm/ferris.nvim',
		opts = {
			-- your options here
		}
	},

}
