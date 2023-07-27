vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
	  -- Packer can manage itself
	use 'wbthomason/packer.nvim'

    -- Theme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Fuzzy finder
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

    -- Syntaxic tree
	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- Small file manager/switcher
	use('theprimeagen/harpoon')

    -- Easy comment
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

    -- Sets of plugin for lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim',
                run = function()
                    pcall(vim.api.nvim_command, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }

    -- Status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    -- Tree file
    use { 'nvim-tree/nvim-tree.lua' }

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

end)
