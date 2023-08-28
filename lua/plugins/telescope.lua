return {
    'nvim-telescope/telescope.nvim', -- Fuzzy finder
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = {
        defaults = {
            layout_strategy = "vertical",
            layout_config = {
                vertical = {
                    width = 0.7
                }
            }
        },
        pickers = {
            find_files = {
                find_command = { "fd", "-I" },
            }
        }
    },
    keys = {
        -- <C-x> open in split
        -- <C-v> open in vsplit
        -- <C-t> open in new tab
        { '<leader>fa', "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
        { '<leader>ff', "<cmd>Telescope git_files<cr>",  desc = "Telescope git files" },
        { '<leader>fg', "<cmd>Telescope live_grep<cr>",  desc = "Telescope live grep" }
    }
}
