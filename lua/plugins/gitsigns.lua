return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        require('gitsigns').setup({})
    end,
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        {"<leader>gs", "<cmd>Gitsign preview_hunk<cr>", "Gitsign show hunk"},
        {"<leader>gt", "<cmd>Gitsign toggle_current_line_blame<cr>", "Gitsign toggle line blame"},
        {"<leader>gb", "<cmd>Gitsign blame_line<cr>", "Gitsign line blame"},
    }
}
