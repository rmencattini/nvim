local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>r", mark.rm_file)
vim.keymap.set("n", "<leader>cc", mark.clear_all)
vim.keymap.set("n", "<leader>o", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-q>", function() ui.nav_prev() end) 
vim.keymap.set("n", "<C-p>", function() ui.nav_next() end)

