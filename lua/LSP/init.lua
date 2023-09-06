local n_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


  local ih = require("inlay-hints")
  ih.set_all()
  ih.on_attach(client, bufnr)

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
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  else
    vim.keymap.set('n', '<leader>ca', actions.code_actions, bufopts)
  end


  --  vim.keymap.set('n', '<leader>fo', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, bufopts)
end -- on_attach



local lua_settings = require("LSP/settings").lua_settings
local rust_settings = require("LSP/settings").rust_settings
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local rust_on_attach = require("LSP/settings").rust_on_attach

local config = {
  virtual_text = false,
}

vim.diagnostic.config(config)


require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- require("mason-nvim-dap").setup()

-- require("LSP.dap-conf")

require("mason-lspconfig").setup()

require("lspconfig").lua_ls.setup { settings = lua_settings, on_attach = n_on_attach, capabilities = capabilities }

require("lspconfig").rust_analyzer.setup {
  settings = {

    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy" -- default: check
      },
      procMacro = {
        enable = true -- default: false
      },
      editor = {
        formatOnType = true,
      }
    },
  },

  on_attach = n_on_attach,

  capabilities = capabilities,
}
-- require("rust-tools").setup({ on_attach = rust_on_attach })

require("lspconfig").marksman.setup {}
require("lspconfig").asm_lsp.setup {
  capabilities = capabilities,
}

--[[require("lint").linters_by_ft = {
  Lua = { 'selene', }
}]]
-- require("lspconfig").pyright.setup { on_attach = on_attach }
