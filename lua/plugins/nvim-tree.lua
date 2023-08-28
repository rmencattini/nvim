return {
    'nvim-tree/nvim-tree.lua',       -- Tree file
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    keys = {
        {"<leader>pv", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Nvim Tree"}
    },
    config = {
    update_focused_file = {
        enable = true,
    }
},
}
