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
  return
end


vim.g.mapleader = " "
vim.g.maplocalleader = " "
lazy.setup({

  {
    enabled = false,
    "lewis6991/impatient.nvim", -- Fast
    setup = function()
      require("impatient")
    end,
  },

  -------------------------------------------Completion-------------------------------------
  -- CMP Plugins
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path", -- path completions
      "L3MON4D3/LuaSnip", -- snippet engine
      -- "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
      { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end },
      -- { "saecki/crates.nvim", dependencies = "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("cmp-conf")
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("LSP")
    end,
    dependencies = {
      { "simrat39/inlay-hints.nvim", config = function() require("inlay-hints").setup {} end },
    },
  },

  {
    "williamboman/mason.nvim",
    dependencies = "williamboman/mason-lspconfig.nvim",
    cmd = "Mason",
  },

  "folke/neodev.nvim",


  ----------------------------------------Utility---------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "BurntSushi/ripgrep",
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
  },
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    version = "nightly",
    config = function()
      require("nvim-tree").setup {
        sync_with_root_cwd = true,
        respect_buf_cwd = false,
        update_focused_file = {
          enable = true,
          update_root = false,
        }
      }
    end,
    keys = {
      { "<C-m>", ":NvimTreeToggle<CR>", desc = "NvimTree" },
    }
  },

  {
    "akinsho/toggleterm.nvim", version = '*',
    config = function()
      require("toggleterm").setup {
        shell = vim.g.terminal_emulator
      }
    end,
    keys = {
      { "<leader>tt", "<cmd> ToggleTerm size=50 direction=vertical<CR>", desc = "Open Terminal" },
    }
  },

  {
    "asiryk/auto-hlsearch.nvim",
    version = "*",
    config = function()
      require("auto-hlsearch").setup {}
    end
  },

  {
    "gbprod/yanky.nvim",
    config = function ()
      require("yanky").setup {}
    end,
    keys = {
      { "P", "<Plug>YankyRingHistory", desc = "Open yank history" },
    },
    lazy = false,
  },

  {
    enabled = false,
    'Bekaboo/dropbar.nvim',
    -- config = function ()
      -- require("dropbar").setup()
    -- end,
    event = "VeryLazy",
    keys = {
      { "<leader><A-m>", }
    }
  },

  {
    "ErichDonGubler/lsp_lines.nvim",
    config = function ()
      require("lsp_lines").setup()
    end,
    keys = {
      { "<leader>R", ":lua require('lsp_lines').toggle()<CR>", desc = "toggle lsp_lines instead of vim diagnostic" },
    },
  },


  {
    enabled = false,
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    config = function ()
      require("hardtime").setup()
    end,
  },


  ------------------------- Graphics ---------------------------------------------------------------
  { 'dasupradyumna/midnight.nvim', lazy = true },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function ()
      require("kanagawa").setup {
        compile = true,
        theme = "dragon",
      }
    end
  },

  {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require("screen")
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function ()
      require("bufferline-conf")
    end
  },


  -- SLOW 70ms
  {
    enabled = false,
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("lualine-conf")
    end,
    event = "VeryLazy",
  },
  -- Alternative
  {
    enabled = false,
    "famiu/feline.nvim",
    config = function ()
      require("feline").setup {}
    end
  },

  {
    enabled = true,
    "windwp/windline.nvim",
    config = function ()
      -- require('wlsample.vscode')
      require('wlsample.evil_line')
      require("windline-conf")
    end,
    event = "VeryLazy",
  },

  {
    "folke/noice.nvim",
    enabled = false,
    config = function()
      require("noice").setup({
        -- add any options here
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = false,
            auto_open = {
              enabled = true,
              trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
              luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
              throttle = 50, -- Debounce lsp signature help request by 50ms
            },
            view = nil, -- when nil, use defaults from documentation
            opts = {}, -- merged with defaults from documentation
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

})
