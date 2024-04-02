local colors = require("sttusline.utils.color")

-- FILENAME
local filename = require("sttusline.components.filename")

filename.set_config {
	color = { fg = colors.orange, bg = colors.black },
}

-- MODE
local mode = require("sttusline.components.mode")

mode.set_config {
	color = { bg = colors.black },
}

-- GIT-BRANCH
local git_branch = require("sttusline.components.git-branch")

git_branch.set_config {
	color = { bg = colors.black },
}

-- GIT-DIFF
local git_diff = require("sttusline.components.git-diff")

git_diff.set_config {
	color = { bg = colors.black },
}

-- DATETIME
local datetime = require("sttusline.components.datetime")

datetime.set_config {
	color = { bg = colors.black },
}

-- DIAGNOSTICS
local diagnostics = require("sttusline.components.diagnostics")

diagnostics.set_config {
	color = { bg = colors.black },
}

-- LSPS-FORMATTERS
local formats = require("sttusline.components.lsps-formatters")

formats.set_config {
	color = { bg = colors.black },
}

-- INDENT
local indent = require("sttusline.components.indent")

indent.set_config {
	color = { bg = colors.black },
}

-- ENCODING
local encoding = require("sttusline.components.encoding")

encoding.set_config {
	color = { bg = colors.black },
}

-- POS-CURSOR
local pos = require("sttusline.components.pos-cursor")

pos.set_config {
	color = { bg = colors.black },
}

-- PROGRESS
local progress = require("sttusline.components.pos-cursor-progress")

progress.set_config {
	color = { bg = colors.black },
}


return { filename, mode }
