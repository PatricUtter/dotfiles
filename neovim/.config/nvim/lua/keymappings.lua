vim.g.mapleader = " "

vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("x", "<leader>p", '"+p')

vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("x", "<leader>y", '"+y')

--fancy block mover
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv")

-- Navigator keybindings
vim.keymap.set("n", "<C-h>", require("Navigator").left)
vim.keymap.set("n", "<C-k>", require("Navigator").up)
vim.keymap.set("n", "<C-l>", require("Navigator").right)
vim.keymap.set("n", "<C-j>", require("Navigator").down)

-- Telescope keybindings
vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>F", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>h", require("telescope.builtin").help_tags)

-- Formatting
vim.keymap.set("n", "<leader>,", "<cmd>lua vim.lsp.buf.formatting()<CR>")

-- Nvim-tree
vim.keymap.set("n", "<leader><Tab>", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader><leader><Tab>", "<cmd>NvimTreeFindFile<CR>")

-- Hop
vim.keymap.set("n", "s", require("hop").hint_char2)

-- Fugutive
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
vim.keymap.set("n", "<leader>gw", "<cmd>Git commit<CR>")
