return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.api.nvim_command, 'MasonUpdate')
            end,
        },
        'williamboman/mason-lspconfig.nvim',     -- Lspconfig with mason

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
    config = function()
        local util = require('lspconfig/util')
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
                'gopls',       -- Go coding
            },
        })

        local on_attach = (function(_, bufnr)
            -- Set the completion shortcut + go back
            local opts = { buffer = bufnr }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end, opts)
            vim.keymap.set("n", "<leader>coi", function() require('jdtls').organize_imports() end, opts)
        end)

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
        -- Go
        require('lspconfig').gopls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true
                    }
                }
            }
        })
        -- Rust
        require("lspconfig").rust_analyzer.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ['rust-analyzer'] = {
                    check = {
                        command = "clippy",
                        extraArgs = { "--", "-Dclippy::pedantic" }
                    }
                }
            }
        })
    end
}
