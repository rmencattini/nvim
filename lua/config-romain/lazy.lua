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

require("lazy").setup({
    { "catppuccin/nvim",                 name = "catppuccin" }, -- Theme
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' }, -- Syntaxic tree

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.api.nvim_command, 'MasonUpdate')
                end,
            },
            'williamboman/mason-lspconfig.nvim', -- Lspconfig with mason

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            { "folke/neodev.nvim", opts = {} },
        }
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },


    'nvim-telescope/telescope.nvim',       -- Fuzzy finder
    'nvim-lua/plenary.nvim',               -- Utility function
    'nvim-tree/nvim-web-devicons',         -- Some required icons
    'nvim-lualine/lualine.nvim',           -- Status bar
    'nvim-tree/nvim-tree.lua',             -- Tree file
    'theprimeagen/harpoon',                -- Small file manager/switcher
    'numToStr/Comment.nvim',               -- Easy comment
    "mfussenegger/nvim-jdtls",             -- Helper for java lsp
    'zbirenbaum/copilot.lua',              -- Copilot
    'akinsho/bufferline.nvim',             -- Display buffer as tab
    "lukas-reineke/indent-blankline.nvim", -- Display indent
    'echasnovski/mini.surround',           -- Easy surround
    'echasnovski/mini.pairs',              -- Easy pairs
})
