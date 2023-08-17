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
    -- Theme
    { "catppuccin/nvim", name = "catppuccin" },
    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    -- Syntaxic tree
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    -- Small file manager/switcher
    'theprimeagen/harpoon',
    -- Easy comment
    {
        'numToStr/Comment.nvim',
    },
    {
        "mfussenegger/nvim-jdtls",
    },
    -- Sets of plugin for lsp
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },     -- Required
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.api.nvim_command, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },     -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'L3MON4D3/LuaSnip' },         -- Required
        }
    },
    -- Status bar
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },
    -- Tree file
    'nvim-tree/nvim-tree.lua',
    'windwp/nvim-autopairs',
    'zbirenbaum/copilot.lua',
})
