vim.g.mapleader = " "

-- General
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("x", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("x", "<leader>y", '"+y')
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "g*", "g*zz")
vim.keymap.set("n", "g#", "g#zz")

-- Quickfix list
vim.keymap.set("n", "<leader>n", ":cnext<cr>")
vim.keymap.set("n", "<leader>N", ":cp<cr>")

--fancy block mover
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv")

-- Navigator keybindings
vim.keymap.set("n", "<C-h>", require("Navigator").left)
vim.keymap.set("n", "<C-k>", require("Navigator").up)
vim.keymap.set("n", "<C-l>", require("Navigator").right)
vim.keymap.set("n", "<C-j>", require("Navigator").down)

-- Telescope keybindings
local opts = { path_display = { "truncate" } }
vim.keymap.set("n", "<C-p>", function()
	require("telescope.builtin").find_files(opts)
end)
vim.keymap.set("n", "<leader>F", function()
	require("telescope.builtin").live_grep(opts)
end)
vim.keymap.set("n", "<leader>b", function()
	require("telescope.builtin").buffers(opts)
end)
vim.keymap.set("n", "<leader>h", function()
	require("telescope.builtin").help_tags(opts)
end)
vim.keymap.set("n", "<leader>*", function()
	require("telescope.builtin").grep_string(opts)
end)

-- Formatting
vim.keymap.set("n", "<leader>,", "<cmd>lua vim.lsp.buf.format()<CR>")

-- Nvim-tree
vim.keymap.set("n", "<leader><Tab>", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader><leader><Tab>", "<cmd>NvimTreeFindFile<CR>")

-- Hop
vim.keymap.set("n", "ss", require("hop").hint_char2)
-- some hop and change
vim.keymap.set("n", "sc", function()
	require("hop").hint_char2()
	vim.cmd([[execute 'normal diw']])
	vim.cmd([[startinsert]])
end)
vim.keymap.set("n", "sd", function()
	require("hop").hint_char2()
	vim.cmd([[execute 'normal diw']])
end)
vim.keymap.set("n", 's"', function()
	require("hop").hint_char2()
	vim.cmd([[execute 'normal di"']])
	vim.cmd([[startinsert]])
end)
vim.keymap.set("n", "s'", function()
	require("hop").hint_char2()
	vim.cmd([[execute "normal di'"]])
	vim.cmd([[startinsert]])
end)
vim.keymap.set("n", "s{", function()
	require("hop").hint_char2()
	vim.cmd([[execute 'normal di{']])
	vim.cmd([[startinsert]])
end)
vim.keymap.set("n", "s(", function()
	require("hop").hint_char2()
	vim.cmd([[execute 'normal di(']])
	vim.cmd([[startinsert]])
end)
vim.keymap.set("n", "s[", function()
	require("hop").hint_char2()
	vim.cmd([[execute 'normal di[']])
	vim.cmd([[startinsert]])
end)

-- Fugutive
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
vim.keymap.set("n", "<leader>gw", "<cmd>Git commit<CR>")

-- Diagnostics
vim.keymap.set("n", "g?", vim.diagnostic.open_float)

-- Substitution
vim.keymap.set("n", "<leader>s", ":%s/<c-r><c-w>/")
