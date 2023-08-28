return {
    'numToStr/Comment.nvim', -- Easy comment
    keys = {
        { "gcc", desc = "Comment line" },
        { "gbc", desc = "Comment block" },
        { "gc",  desc = "Comment line visual",  mode = { "v" } },
        { "gb",  desc = "Comment block visual", mode = { "v" } },
    },
    opts = {}
}
