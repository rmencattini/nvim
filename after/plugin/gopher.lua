require("gopher").setup({})

vim.keymap.set("n", "<leader>gsj", "<cmd>GoTagAdd json<CR>")
vim.keymap.set("n", "<leader>gsy", "<cmd>GoTagAdd yaml<CR>")
vim.keymap.set("n", "<leader>gie", "<cmd>GoIfErr<CR>")
