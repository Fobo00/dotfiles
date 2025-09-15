return {

	---------------------------------------Rust----------------------------------------
	{
		'mrcjkb/rustaceanvim',
		version = '^5', -- Recommended,
		lazy = false,
		config = function()

			-- local extension_path = vim.env.HOME .. '/AppData/Local/nvim-data/mason/packages/codelldb/extension'
			-- local codelldb_path = extension_path .. '/adapter/codelldb'
			-- local liblldb_path = extension_path .. '/lldb/lib/liblldb'
			-- local this_os = vim.uv.os_uname().sysname;
			--
			-- if this_os:find "Windows" then
			-- 	codelldb_path = extension_path .. "\\adapter\\codelldb.exe"
			-- 	liblldb_path = extension_path .. "\\lldb\\bin\\liblldb.dll"
			-- else
			-- 	-- The liblldb extension is .so for Linux and .dylib for MacOS
			-- 	liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
			-- end
			--
			-- local cfg = require("rustaceanvim.config")
			-- dap = {
			-- 	adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
			-- },

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
						vim.keymap.set('n', '<leader><A-r>', vim.cmd.RustLsp('renderDiagnostic'), bufopts)
						vim.keymap.set('n', '<leader>ca', ":RustLsp codeAction<CR>", bufopts)
						vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
						--  vim.keymap.set('n', '<leader>fo', vim.lsp.buf.formatting, bufopts)
						vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, vim.tbl_extend('force', bufopts, { desc = "Format File"}))
						vim.keymap.set('n', '<leader>dbg', vim.cmd.RustLsp { 'debuggables' }, bufopts)
					end, -- on_attach
					default_settings = {
						-- rust-analyzer language server configuration
						['rust-analyzer'] = {
							checkOnSave = {
								command = "clippy",
							},
						},
					},
				},
			}
		end
	},
}
