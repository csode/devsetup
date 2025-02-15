vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""
vim.o.laststatus = 2  -- Always show the statusline
function GitBranch()
  local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  local result = handle:read("*a") or ""
  handle:close()
  result = result:gsub("\n", "") -- Remove newline
  return result ~= "" and "Git branch - " .. result or ""
end

vim.cmd("highlight StatusLine guifg=#FFFFFF ctermfg=15")
vim.o.statusline = "%#StatusLine# %t %m %y %{v:lua.GitBranch()} [%l/%L] %p%%"
