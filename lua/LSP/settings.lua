-- settings
local lua_settings = {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" }, },
			hint = {
				enable = true,
			},
			workspace = {
				library = { [vim.fn.expand("$VIMRUNTIME/lua")] = true, [vim.fn.stdpath("config") .. "/lua"] = true, }, },
			completion = {
				callSnippet = "Replace",
			},
		},
	}
}

local rust_settings = {
	settings = {
		["rust_analyzer"] = {
			checkOnSave = {
				command = "clippy" -- default: check
			},

			check = {
				command = "clippy"
			},

			procMacro = {
				enable = true -- default: false
			},

			inlayHints = {
				closureCaptureHints = {
					enable = true
				},
			},

			interpret = {
				tests = {
					enable = true
				},
			},

		},
	},
}


local rust_on_attach = function(_, bufnr)
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
end -- on_attach


Settings = {
	lua_settings,
	rust_settings,
	rust_on_attach,
}

return { Settings, }
