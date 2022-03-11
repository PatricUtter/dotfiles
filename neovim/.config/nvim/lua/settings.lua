vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox-material]])
vim.o.hidden = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = "a"
vim.cmd("set ts=4")
vim.cmd("set sw=4")
vim.cmd("set expandtab")
vim.o.cursorline = true
vim.o.showmode = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.clipboard = "unnamedplus"
vim.cmd([[set signcolumn=yes]])

-- Neede for nvim.cmp to work
vim.cmd([[set completeopt=menu,menuone,noselect]])

-- Icons for diagnostigs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Color adjustments, these need to run after other color settings have run
vim.cmd([[hi SignColumn guibg=235]])
vim.cmd([[hi GreenSign guibg=235]])
vim.cmd([[hi BlueSign guibg=235]])
vim.cmd([[hi RedSign guibg=235]])
