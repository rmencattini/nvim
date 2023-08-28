return {  -- Syntaxic tree
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = {"BufEnter *.*"},
    config = {
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        ensure_installed = { "javascript", "typescript", "html", "scss", "css" },
        auto_install = true,

        highlight = {
            enable = true,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    }
}
