return {
    {
        "L3MON4D3/LuaSnip",
        -- Follow latest release.

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")

            -- Extend filetypes for LuaSnip to include custom language types (e.g., jsdoc, cpp, rust)
            ls.filetype_extend("javascript", { "jsdoc" })
            ls.filetype_extend("cpp", { "c", "cpp" })  -- Use both C and C++ snippets
            ls.filetype_extend("rust", { "rust" })
            ls.filetype_extend("c", { "c" })

            -- Set key mappings globally for snippet expansion and navigation
            vim.keymap.set({"i", "s"}, "<C-s>e", function() ls.expand() end, {silent = true})  -- Expand snippet
            vim.keymap.set({"i", "s"}, "<C-s>;", function() ls.jump(1) end, {silent = true})   -- Jump forward
            vim.keymap.set({"i", "s"}, "<C-s>,", function() ls.jump(-1) end, {silent = true})  -- Jump backward

            -- Change choice for active snippet (if applicable)
            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {silent = true})
        end,
    }
}

