function ColorMyPencils(color)
    require('catppuccin').setup({
        flavour = "mocha"
    })

	color = color or vim.cmd('colorscheme catppuccin')
end

ColorMyPencils()
