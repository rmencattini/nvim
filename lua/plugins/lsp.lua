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
        'williamboman/mason-lspconfig.nvim', -- Lspconfig with mason

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                'lua_ls',      -- To configure neovim
                'jdtls',       -- Java coding
                'volar',       -- Vuejs coding
                'html',        -- Handlebars coding
                'tailwindcss', -- Handlebars coding
                'ltex',        -- Spelling correction
                'efm',
            },
        })

        local on_attach = (function(_, bufnr)
            local opts = { buffer = bufnr }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ timeout_ms = 2000 }) end, opts)
            vim.keymap.set("n", "<leader>coi", function() require('jdtls').organize_imports() end, opts)
        end)

        local signs = { Error = "", Warn = "", Hint = "💡", Info = " " }

        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Lua
        require('lspconfig').lua_ls.setup({ on_attach = on_attach, capabilities = capabilities })
        -- Html
        require('lspconfig').html.setup({ on_attach = on_attach, capabilities = capabilities })
        -- Tailwind
        require('lspconfig').tailwindcss.setup({ on_attach = on_attach, capabilities = capabilities })
        -- Text spelling / ltex
        require('lspconfig').ltex.setup({ capabilities = capabilities, on_attach = on_attach })
        -- Vuejs
        require('lspconfig').volar.setup({
            filetypes = { "vue", "typescript" },
            root_dir = require('lspconfig').util.root_pattern('package.json'),
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
                on_attach(client, bufnr)
            end,
            capabilities = capabilities,
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
        -- Efm
        local eslint = {
            lintCommand =
            "eslint -f unix --stdin -c config/lints/.eslintrc.yml --stdin-filename ${INPUT}",
            lintStdin = true,
            lintFormats = { "%f:%l:%c: %m" },
            lintIgnoreExitCode = true,
            formatCommand = "eslint_d -c config/lints/.eslintrc.yml --fix-to-stdout --stdin --stdin-filename=${INPUT}",
            formatStdin = true,
        }
        require('lspconfig').efm.setup({
            init_options = { documentFormatting = true, documentRangeFormatting = true },
            root_dir = require('lspconfig').util.root_pattern({ 'package.json' }),
            settings = {
                languages = {
                    vue = { eslint },
                    typescript = { eslint },
                }
            },
            filetypes = { "vue", "typescript", }
        })
    end
}
