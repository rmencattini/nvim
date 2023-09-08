return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    event = "LspAttach",
    keys = {
        { '<leader>tt', "<cmd>TroubleToggle<cr>", desc = "Trouble Toggle" },
    }
}
