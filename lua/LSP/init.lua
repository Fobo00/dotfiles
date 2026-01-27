vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local bufnr = args.buf
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

		vim.keymap.set('n', 'K', function()
			vim.lsp.buf.hover()
		end, bufopts)

		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)

		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<A-S>', vim.lsp.buf.workspace_symbol, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

		local actions_ok, actions = pcall(require, "actions-preview")
		if not actions_ok then
			-- print("actions-preview not found!")
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
				vim.tbl_extend('force', bufopts, { desc = "Code Actions" }))
		else
			vim.keymap.set('n', '<leader>ca', actions.code_actions,
				vim.tbl_extend('force', bufopts, { desc = "Code Actions" }))
		end

		--  vim.keymap.set('n', '<leader>fo', vim.lsp.buf.formatting, bufopts)
		vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, bufopts)
	end
})


local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- local rust_on_attach = require("LSP/settings").rust_on_attach

local config = {
	virtual_text = false,
}

vim.diagnostic.config(config)


-- require("lspconfig").lua_ls.setup { settings = {
-- 	Lua = {
-- 		-- workspace = {
-- 		-- 	library = { [vim.fn.expand("$VIMRUNTIME/lua")] = true, [vim.fn.stdpath("config") .. "/lua"] = true, }, },
-- 		completion = {
-- 			callSnippet = "Replace",
-- 		}
-- 	}
-- }, on_attach = n_on_attach, capabilities = capabilities }
--
-- require("lspconfig").clangd.setup { on_attach = n_on_attach, capabilities = capabilities }
--
-- require("lspconfig").hls.setup { on_attach = n_on_attach, capabilities = capabilities }
--
-- require("lspconfig").wgsl_analyzer.setup { on_attach = n_on_attach, capabilities = capabilities }
--
-- --[[ require("lspconfig").rust_analyzer.setup {
--   settings = {
--
--     ["rust-analyzer"] = {
--       checkOnSave = {
--         command = "clippy" -- default: check
--       },
--       procMacro = {
--         enable = true -- default: false
--       },
--       editor = {
--         formatOnType = true,
--       }
--     },
--   },
--
--   on_attach = n_on_attach,
--
--   capabilities = capabilities,
-- }]]
-- -- require("rust-tools").setup({ on_attach = rust_on_attach })
--
-- require("lspconfig").marksman.setup {}
-- require("lspconfig").asm_lsp.setup {
-- 	capabilities = capabilities,
-- 	on_attach = n_on_attach,
-- }
--
-- require("lspconfig").emmet_language_server.setup({
--     -- on_attach = on_attach,
--     capabilities = capabilities,
-- 	on_attach = n_on_attach,
-- })
--
-- require("lspconfig").ts_ls.setup {
-- 	capabilities = capabilities,
-- 	on_attach = n_on_attach,
-- }
--
-- local pid = vim.fn.getpid()
-- require("lspconfig").omnisharp.setup {
-- 	cmd = { "omnisharp-mono", "--languageserver", "--hostPID", tostring(pid) },
-- 	capabilities = capabilities,
-- 	on_attach = n_on_attach,
-- }
--
-- require("lspconfig").nixd.setup {
-- 	capabilities = capabilities,
-- 	on_attach = n_on_attach,
-- }

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			completion = {
				callSnippet = "Replace",
			}
		}
	},
})

local pid = vim.fn.getpid()
vim.lsp.config("omnisharp", {
	cmd = { "omnisharp-mono", "--languageserver", "--hostPID", tostring(pid) },
})

vim.lsp.enable({
	"lua_ls",
	"clangd",
	"hls",
	"wgsl_analyzer",
	"marksman",
	"basedpyright",
	"asm_lsp",
	"emmet_language_server",
	"ts_ls",
	"omnisharp",
	"nixd",
})
