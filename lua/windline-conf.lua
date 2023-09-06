local windline = require("windline")

local default = {
  filetypes = {'default'},
  active = {
    --components
  },
  inactive = {

  }
}

local explorer = {
  filetypes = {'fern', 'NvimTree','netrw'},
  active = {
      {'  ', {'white', 'black'} },
  },
  --- show active components when the window is inactive
  always_active = true,
  --- It will display a last window statusline even that window should inactive
  show_last_status = true
}





windline.setup({
  statuslines = {
    explorer,
  }
})
