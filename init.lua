require("options")
require("keymaps")

if vim.g.neovide then
	require("neovide")
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy_status, lazy = pcall(require, "lazy")
if not lazy_status then
	print "Lazy.nvim not found!"
	return
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

lazy.setup("plugins");
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")
local wk = require("which-key")
-- require("plugins")
-- require("treesitter-conf")
-- require("test-plugs")


-- vim.cmd("colorscheme kanagawa-dragon")
-- print(vim.uv.now())
