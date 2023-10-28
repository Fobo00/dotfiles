local colors = require("sttusline.utils.color")

local filename = require("sttusline.components.filename")

filename.set_config {
	color = { fg = colors.orange , bg = colors.black },
}

local mode = require("sttusline.components.mode")

mode.set_config {
	color = { bg = colors.black },
}

return { filename, mode }
