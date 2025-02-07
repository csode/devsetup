require("theprimeagen.set")
require("theprimeagen.remap")
require("theprimeagen.lazy_init")

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not
local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})


local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
vim.api.nvim_create_user_command(
  "Build",
  function()
    vim.cmd("!build")
  end,
  { desc = "Run the build alias from Neovim" }
)

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('BufEnter', {
    group = ThePrimeagenGroup,
    callback = function()
            vim.cmd.colorscheme("tokyonight")
vim.cmd [[highlight CursorLineNr guifg=#FFA500]]

-- Set the rest of the line numbers (LineNr) color to white
vim.cmd [[highlight LineNr guifg=#FFFFFF]]

    end
})


autocmd('LspAttach', {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gb", "<C-o>", { noremap = true, silent = true })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.api.nvim_set_keymap("n", "<leader><leader>)", ":source ~/.config/nvim/init.lua<CR>", { noremap = true, silent = true })

    end
})
local cmp = require'cmp'

cmp.setup({
     mapping = cmp.mapping.preset.insert({
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),  -- Select previous item
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),  -- Select next item
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirm the selected item
    ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion manually
  }),

  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
})

vim.opt.shell = "/usr/bin/zsh"
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.api.nvim_set_keymap('n', '<leader>gq', ':Gen Ask<CR>', { noremap = true, silent = true })
-- Configure LSP diagnostics and key mappings
vim.api.nvim_set_keymap('n', '<Leader>dq', ':lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true }) -- Open quickfix list with LSP diagnostics
vim.api.nvim_set_keymap('n', '<Leader>fn', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true }) -- Jump to next diagnostic
vim.api.nvim_set_keymap('n', '<Leader>fp', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true }) -- Jump to previous diagnostic
vim.api.nvim_set_keymap('n', '<Leader>hd', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true }) -- Open floating diagnostic
vim.api.nvim_set_keymap('n', '<Leader>fq', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true }) -- Trigger LSP code actions

