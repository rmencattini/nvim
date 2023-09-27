return { -- Syntaxic tree
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufEnter *.*" },
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "javascript", "typescript", "html", "scss", "css" },
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end
}
