local impa_status, _ = pcall(require, "impatient")
if not impa_status then
  print("Impatient not found")
end

require("options")
require("plugins")
-- require("treesitter-conf")
-- require("test-plugs")
--[[require("keymaps")
require("cmp-conf")
require("LSP")

require("bufferline-conf")
require("lualine-conf")]]


-- vim.cmd [[colorscheme midnight]]
