local util = require('lspconfig/util')
local luasnip = require("luasnip")
local cmp = require('cmp')

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        'lua_ls',      -- To configure neovim
        'jdtls',       -- Java coding
        'volar',       -- Vuejs coding
        'html',        -- Handlebars coding
        'tailwindcss', -- Handlebars coding
        'astro',       -- Github page dev
        'ltex',        -- Spelling correction
        'zls',
        'gopls',
    },
    automatic_installation = true
})

local on_attach = (function(_, bufnr)
    -- Set the completion shortcut + go back
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>of", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>coi", function() require('jdtls').organize_imports() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Efm
-- require("lspconfig").efm.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     init_options = { documentFormatting = true },
--     settings = {
--         rootMarkers = { ".git/" },
--         languages = {
--             lua = {
--                 { formatCommand = "lua-format -i", formatStdin = true }
--             }
--         }
--     }
-- }
-- Lua
require('lspconfig').lua_ls.setup({ on_attach = on_attach, capabilities = capabilities })
-- Vuejs
require('lspconfig').volar.setup({
    filetypes = { "vue", "typescript" },
    on_attach = on_attach,
    capabilities = capabilities,
})
-- Html
require('lspconfig').html.setup({ on_attach = on_attach, capabilities = capabilities })
-- Tailwind
require('lspconfig').tailwindcss.setup({ on_attach = on_attach, capabilities = capabilities })
-- Astro
require('lspconfig').astro.setup({
    filetypes = { "astro" },
    root_dir = util.root_pattern("astro.config.mjs"),
    capabilities = capabilities,
    on_attach = on_attach
})
-- Text spelling / ltex
require('lspconfig').ltex.setup({
    flags = { debounce_text_changes = 60 },
    capabilities = capabilities,
    on_attach = on_attach
})
-- Zig
require('lspconfig').zls.setup({ on_attach = on_attach, capabilities = capabilities })
-- Go
require('lspconfig').gopls.setup({ on_attach = on_attach, capabilities = capabilities })

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup({})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
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
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp",               keyword_length = 1 },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" }
    })
})
