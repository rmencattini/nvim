require("copilot").setup({
    suggestion = {
        auto_trigger = true,
        debounce = 30,
        keymap = {
            accept = "<C-l>"
        },
    }
})

vim.cmd("Copilot disable")
