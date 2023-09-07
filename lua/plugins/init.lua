return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = "mocha",
                styles = {                   -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" }, -- Change the style of comments
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = { "italic" },
                    booleans = { "italic" },
                    properties = {},
                    types = {},
                    operators = {},
                },
            })

            vim.cmd('colorscheme catppuccin')
        end
    }, -- Theme
}
