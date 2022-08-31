vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.hidden = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = "a"
vim.cmd("set ts=2")
vim.cmd("set sw=2")
vim.cmd("set expandtab")
vim.o.cursorline = true
vim.o.showmode = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.clipboard = "unnamedplus"
vim.cmd([[set signcolumn=yes]])
vim.cmd([[set splitright]])
vim.cmd([[set splitbelow]])

-- Neede for nvim.cmp to work
vim.cmd([[set completeopt=menu,menuone,noselect]])

-- Icons for diagnostigs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Colorscheme etc
--vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.cmd([[colorscheme gruvbox-material]])
-- vim.g.tokyonight_style = "night"
-- vim.cmd([[colorscheme tokyonight]])

-- Color adjustments, these need to run after other color settings have run
vim.cmd([[hi SignColumn guibg=235]])
vim.cmd([[hi GreenSign guibg=235]])
vim.cmd([[hi BlueSign guibg=235]])
vim.cmd([[hi RedSign guibg=235]])
