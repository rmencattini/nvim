local builtin = require('telescope.builtin')
-- <C-x> open in split
-- <C-v> open in vsplit
-- <C-t> open in new tab
vim.keymap.set('n', '<leader>fa', builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local telescope = require('telescope')
telescope.setup({
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
})
