local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)









  use "lewis6991/impatient.nvim" -- FAST



  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup {}
  end
  }


  use {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = "BurntSushi/ripgrep",
    config = function ()
      require("telescope").load_extension('projects')
    end
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'nvim-tree/nvim-web-devicons',
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function ()
      require("nvim-tree").setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        }
      }
    end
  }

  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
      }
    end
  }

  -- status lines
  use 'feline-nvim/feline.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp", -- The completion plugin
    "hrsh7th/cmp-buffer", -- buffer completions
    "hrsh7th/cmp-path", -- path completions
    "hrsh7th/cmp-cmdline", -- cmdline completions
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    "norcalli/snippets.nvim",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
--    "hrsh7th/cmp-nvim-lsp-signature-help",
  }
  use {
      'saecki/crates.nvim',
      tag = 'v0.3.0',
      requires = { 'nvim-lua/plenary.nvim' },
  }


  use {
    "ray-x/lsp_signature.nvim",
    config = function ()
      require "lsp_signature".setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded"
        }
      })
    end
  }


  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "folke/neodev.nvim"

  use {
    'antosha417/nvim-lsp-file-operations',
    config = function ()
      require("lsp-file-operations").setup {}
    end,
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "kyazdani42/nvim-tree.lua" },
    }
  }

  use {
    "simrat39/inlay-hints.nvim",
    config = function ()
      require("inlay-hints").setup()
    end
  }

  use {
    disable = true,
      "nvim-neorg/neorg",
      -- ft = "norg",
      config = function()
          require('neorg').setup {
              load = {
                  ["core.defaults"] = {}, -- Loads default behaviour
                  ["core.concealer"] = {}, -- Adds pretty icons to your documents
                  ["core.dirman"] = { -- Manages Neorg workspaces
                      config = {
                          workspaces = {
                              notes = "C:\\Users\\franc\\Documents\\notes",
                          },
                      },
                  },
                  ["core.completion"] = {
                      config = {
                          engine = "nvim-cmp",
                      },
                  }
              }
          }
      end,
      run = ":Neorg sync-parsers",
      requires = "nvim-lua/plenary.nvim",
  }

  -- Debugging
  use { "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup({
        icons = {
          expanded = "⯆",
          collapsed = "⯈",
          circular = "↺"
        },
        mappings = {
          expand = "<CR>",
          open = "o",
          remove = "d"
        },
        sidebar = {
          elements = {
            -- You can change the order of elements in the sidebar
            "scopes",
            "scopes",
            "watches"
          },
          width = 40,
          position = "left" -- Can be "left" or "right"
        },
        tray = {
          elements = {
            "repl"
          },
          height = 10,
          position = "bottom" -- Can be "bottom" or "top"
        }
      })
    end
  }

  use {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require("mason-nvim-dap").setup {
        automatic_setup = true,
      }
    end
  }

  use 'mfussenegger/nvim-lint'
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim"

  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

  use {
    "asiryk/auto-hlsearch.nvim",
    tag = "1.1.0",
    config = function ()
      require("auto-hlsearch").setup {}
    end,
  }

  -- tree sitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"

  ------------------------Graphics--------------------------------------------

  -- Color Theme
  use 'rktjmp/lush.nvim'
  use 'dasupradyumna/midnight.nvim'
  use "tanvirtin/monokai.nvim"
  use {
    disable = true,
    'cesaralvarod/tokyogogh.nvim',
    config = function ()
      require("tokyogogh").setup {
        style = 'night'
      }
    end
  }

  use {
    "sainnhe/everforest",
    config = function()
      vim.cmd[[let g:everforest_background = 'hard']]
    end,
  }

  -- Drop-line
  use {
    disable = true,
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup()
    end
  }


  use {
    disable = false,
    'Bekaboo/dropbar.nvim',
    config = function ()
      require("dropbar").setup()
    end
  }

  use {
    "ErichDonGubler/lsp_lines.nvim",
    config = function ()
      require("lsp_lines").setup()
    end
  }

  use {
    'echasnovski/mini.indentscope',
    branch = 'stable',
    config = function ()
      require("mini.indentscope").setup {}
    end,
  }

  use {
    disable = true,
    "lukas-reineke/indent-blankline.nvim",
    config = function ()
      require("indent_blankline").setup {
        -- show_end_of_line = true,
      }
    end
  }

  use {
    "HampusHauffman/block.nvim",
    config = function ()
      require("block").setup({
        percent = 1.3
      })
    end
  }

  use {
    "aznhe21/actions-preview.nvim",
    config = function ()
      require("actions-preview").setup {
        backend = { "telescope" },
        telescope = require("telescope.themes").get_ivy(),
      }
    end
  }

  use({
    disable = false,
    "folke/noice.nvim",
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
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  })

  use {
      'goolord/alpha-nvim',
      requires = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
        require("screen")
      end,
  }



  --------------------testing---------------------------

  use {
    'simrat39/rust-tools.nvim',
    requires = 'neovim/nvim-lspconfig',
    disable = true,
  }







  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
