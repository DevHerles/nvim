return require("packer").startup(function()
	use("wbthomason/packer.nvim")
    -- use("kyazdani42/nvim-web-devicons") 
 	-- use("kyazdani42/nvim-tree.lua") --> file explorer
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
      'francoiscabrol/ranger.vim',
      requires = { {'rbgrouleff/bclose.vim'} }
    }
    use {
        "williamboman/nvim-lsp-installer",
        "neovim/nvim-lspconfig",
    }
    use({
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                -- overwrite default configuration
                -- here, e.g. to enable default bindings
                copy_sync = {
                    -- enables copy sync and overwrites all register actions to
                    -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
                    enable = true,
                },
                navigation = {
                    -- enables default keybindings (C-hjkl) for normal mode
                    enable_default_keybindings = true,
                },
                resize = {
                    -- enables default keybindings (A-hjkl) for normal mode
                    enable_default_keybindings = true,
                }
            })
        end
    })

    use("EdenEast/nightfox.nvim") --> nightfox colorsceme for neovim
    use('ghifarit53/tokyonight-vim')

end)
