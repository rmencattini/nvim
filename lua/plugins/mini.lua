return {
    { -- Easy surround
        'echasnovski/mini.surround',
        keys = {
            { "sa", desc = "Mini surround add surround",    mode = "v" },
            { "sd", desc = "Mini surround delete surround" },
            { "sr", desc = "Mini surround replace surround" },
        },
        opts = {},
    },
    {
        'echasnovski/mini.pairs',
        event = { "BufReadPre", "BufNewFile" },
        opts = {}
    },
}
