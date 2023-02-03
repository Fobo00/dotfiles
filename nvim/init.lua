require("impatient")

require("options")
require("plugins")
require("keymaps")
require("cmp-conf")
require("LSP")
require("treesitter-conf")

require("bufferline-conf")

require("nvim-tree").setup()
require("feline").setup()

vim.cmd [[colorscheme monokai]]
