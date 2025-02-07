return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Package Management
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Completion
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",

        -- Snippets
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        -- Add lspsaga.nvim plugin
        "glepnir/lspsaga.nvim",

        -- Treesitter for Syntax Highlighting
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",

        -- Debugging
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",

        -- Formatting & Linting
        "jose-elias-alvarez/null-ls.nvim",

        -- Testing
        "vim-test/vim-test",

        -- Git Integration
        "lewis6991/gitsigns.nvim",

        -- Navigation & Symbols
        "simrat39/symbols-outline.nvim",
        "nvim-telescope/telescope.nvim",
        "kyazdani42/nvim-tree.lua",

        -- Additional Dependency for nvim-dap-ui
        "nvim-neotest/nvim-nio",
    },

    config = function()
        local cmp = require("cmp")
        local lspconfig = require("lspconfig")
        local luasnip = require("luasnip")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local on_attach = function(client, bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
        end

        -- Mason setup
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "pyright", "bashls", "rust_analyzer", "ts_ls", "htmx", "html", "clangd", "lua_ls", "cmake", "jsonls", "gopls" },
            automatic_installation = true,
        })

        -- LSP setup for pyright (Python)
        lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- LSP setup for bash-language-server (Bash)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'sh',
            callback = function()
                vim.lsp.start({
                    name = 'bash-language-server',
                    cmd = { 'bash-language-server', 'start' },
                })
            end,
        })

        -- LSP setup for gopls (Go)
        lspconfig.gopls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                },
            },
        })

        -- LSP setup for clangd (C/C++)
        lspconfig.clangd.setup({
            cmd = { "clangd", "--header-insertion=never", "--cross-file-rename" },
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json"),
            dynamicRegistration = true,
        })

        -- LSP setup for ts_ls (TypeScript/JavaScript)
        lspconfig.ts_ls.setup({
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
            on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "<leader>rf", "<cmd>TypescriptRenameFile<CR>", opts)
                vim.keymap.set("n", "<leader>oi", "<cmd>TypescriptOrganizeImports<CR>", opts)
            end,
        })

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
    },
  },
})

        -- Treesitter setup
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"typescript", "javascript", "html", "rust", "cpp", "c", "json", "lua"},
            highlight = { enable = true },
            textobjects = { enable = true },
        })

        -- nvim-cmp setup
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        cmp.mapping.select_next_item()(fallback)
                    end
                end),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        cmp.mapping.select_prev_item()(fallback)
                    end
                end),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),
        })

        -- Formatting and Linting with null-ls
        require("null-ls").setup({
            sources = {
                require("null-ls").builtins.formatting.clang_format,
                require("null-ls").builtins.formatting.rustfmt,
                require("null-ls").builtins.diagnostics.cppcheck,
            },
        })

        -- Debugging with DAP
        local dap = require("dap")
        require("dapui").setup()

        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = "gdb",
            name = "gdb",
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                environment = {},
                externalTerminal = false,
            },
        }

        -- Git integration
        require("gitsigns").setup()

        -- File navigation
        require("nvim-tree").setup()

        -- Symbols Outline
        require("symbols-outline").setup()
    end,
}

