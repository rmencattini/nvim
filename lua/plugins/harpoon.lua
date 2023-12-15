return {
    'ThePrimeagen/harpoon', -- Small file manager/switcher
    branch = "harpoon2",
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    keys = {
        { "<leader>a", desc = "Harpoon add file" },
        { "<leader>o", desc = "Harpoon open menu" },
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
        vim.keymap.set("n", "<leader>o", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    end
}
