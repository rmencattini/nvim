return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require('catppuccin').setup({
                flavour = "mocha"
            })

            vim.cmd('colorscheme catppuccin')
        end
    }, -- Theme
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
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
        }
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },
}
