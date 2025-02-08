
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", ":wq<CR>")
-- Visual mode: Yank to both clipboard and default register
vim.api.nvim_set_keymap('v', 'y', '"+y', { noremap = true, silent = true })
-- Remap `yy` to yank to both clipboard and default register
vim.api.nvim_set_keymap('n', 'yy', '"+yy', { noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.api.nvim_set_keymap("n", "<leader>tt", ":!bash -c '~/scripts/tmux-sessionize.sh' <CR>", { noremap = true, silent = true })

vim.keymap.set("n", "Ff", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set(
    "n",
    "<leader>ea",
    "oassert.NoError(err, \"\")<Esc>F\";a"
)

vim.keymap.set(
    "n",
    "<leader>el",
    "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
)


vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
-- Auto-save when pressing End key
vim.api.nvim_set_keymap('n', '<Esc>', ':write<CR>', { noremap = true, silent = true })
-- Keybinding to toggle Markdown preview
vim.api.nvim_set_keymap('n', '<Leader>mp', ':vsp | terminal glow %<CR>i', { noremap = true, silent = true })


vim.keymap.set('n', '<leader>c', ':lua local lang = vim.fn.input("Enter language for cheatsheet: ") lang = lang ~= "" and lang or "python" vim.cmd("silent !tmux new-window -n \'cheatsheet\' \'curl cheat.sh/" .. lang .. " && zsh\'")<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', "'", '$', { noremap = true, silent = true })
-- Map single quote (') to go to the beginning of the current line
vim.api.nvim_set_keymap('n', ";", '0w', { noremap = true, silent = true })


