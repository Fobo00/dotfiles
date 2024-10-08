local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

--[[local pair_status_ok, auto_pairs = pcall(require, "nvim-autopairs.completion.cmp")
if not pair_status_ok then
	return
end]]

local check_backspace = function()
	local col = vim.fn.col "." - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-v>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm { select = true },
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				--[[elseif snippets.expandable() then
				snippets.expand()]]
			elseif vim.snippet.jumpable(1) then
				vim.schedule(function()
					vim.snippet.jump(1)
				end)
			-- else
			-- 	vim.schedule(function()
			-- 		vim.snippet.jump(1)
			-- 	end)
			-- end
				--[[ elseif snippets.expand_or_jumpable() then
				snippets.expand_or_jump()]]
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i", "s"
		}),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 		--[[elseif snippets.expandable() then
		-- 		snippets.expand()]]
		-- 		--[[ elseif snippets.expand_or_jumpable() then
		-- 		snippets.expand_or_jump()]]
		-- 	else
		-- 		vim.schedule(function()
		-- 			vim.snippet.jump(1)
		-- 		end)
		-- 	end
		-- end, {
		-- 	"s",
		-- }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
				--[[ elseif snippets.jumpable(-1) then
				snippets.jump(-1)]]
			elseif vim.snippet.jumpable(-1) then
				vim.schedule(function()
					vim.snippet.jump(-1)
				end)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lua = "[NVIM_LUA]",
				nvim_lsp = "[NVIM_LSP]",
				snippets = "[Snippet]",
				--        neorg = "[Neorg]",
				buffer = "[Buffer]",
				path = "[Path]",
				-- crates = "[Crates]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "snippets" },
		{ name = "nvim_lsp" },
		--    { name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		--   { name = "neorg" },
		{ name = "buffer" },
		{ name = "path" },
		-- { name = "crates" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = cmp.config.window.bordered(),
		completion = cmp.config.window.bordered(),
	}
	,
	experimental = {
		ghost_text = true,
		native_menu = false,
	},
}

-- local handlers = require("nvim-autopairs.completion.handlers")

-- autopairs
--[[cmp.event:on(
	'confirm_done',
	auto_pairs.on_confirm_done({
		filetypes = {
			["*"] = {
				["("] = {
					kind = {
						cmp.lsp.CompletionItemKind.Function,
						cmp.lsp.CompletionItemKind.Method,
					},
					handler = handlers["*"]
				}
			},
		}
	})
)]]

-- vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
-- 	contents = vim.lsp.util._normalize_markdown(contents, {
-- 		width = vim.lsp.util._make_floating_popup_size(contents, opts),
-- 	})
--
-- 	vim.bo[bufnr].filetype = "markdown"
-- 	vim.treesitter.start(bufnr)
-- 	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
--
-- 	return contents
-- end

-- require('crates').setup {}
