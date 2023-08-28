return {
    'theprimeagen/harpoon', -- Small file manager/switcher
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    keys = {
        { "<leader>a", desc = "Harpoon add file" },
        { "<leader>o", desc = "Harpoon open menu" },
    },
    config = function()
        vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
        vim.keymap.set("n", "<leader>o", require("harpoon.ui").toggle_quick_menu)
    end
}
