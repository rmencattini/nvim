local lsp = require('lsp-zero').preset({})
local util = require('lspconfig/util')

lsp.on_attach(function(_, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)

lsp.ensure_installed({
    'rust_analyzer', -- Wanna learn it
    'lua_ls',        -- To configure neovim
    'jdtls',         -- Java coding
    'volar',         -- Vuejs coding
    'html',          -- Handlebars coding
    'tailwindcss',   -- Handlebars coding
    'astro',         -- Github page dev
    'ltex',          -- Spelling correction
})

-- Set the completion shortcut + go back
lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>coi", function() require('jdtls').organize_imports() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- You need to setup `cmp` after lsp-zero
local cmp = require('cmp')

cmp.setup({
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end),
    }
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').rust_analyzer.setup({
    filetypes = { "rust" },
    root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true
            }
        }
    }
})

require('lspconfig').volar.setup({
    filetypes = { "vue", "typescript" }
})
require('lspconfig').html.setup({})
require('lspconfig').tailwindcss.setup({})
require('lspconfig').astro.setup({
    filetypes = { "astro" },
    root_dir = util.root_pattern("astro.config.mjs")
})
require('lspconfig').ltex.setup({
    flags = { debounce_text_changes = 60 },
})

require('lsp-zero').skip_server_setup({ 'jdtls' })

lsp.setup()
