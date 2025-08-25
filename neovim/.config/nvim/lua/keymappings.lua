-- already defined in the lazy config
--vim.g.mapleader = " "

-- General
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("v", "ii", "<Esc>")
vim.keymap.set("v", "ii", "<Esc>")
-- Todo look into why these don't behave as expected
vim.keymap.set("x", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("x", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "g*", "g*zz")
vim.keymap.set("n", "g#", "g#zz")
vim.keymap.set("i", "{<CR>", "{<CR>}<Esc>O")
vim.keymap.set("i", "[<CR>", "[<CR>]<Esc>O")
vim.keymap.set("i", "(<CR>", "(<CR>)<Esc>O")
-- :vertical resize +5<CR>
-- " noremap <silent> <C-S-Right> :vertical resize -5<CR>
-- noremap <silent> <C-S-Left> :vertical resize +1<CR>
-- noremap <silent> <C-S-Right> :vertical resize -1<CR>
vim.keymap.set("n", "<leader><Up>", ":resize +10<cr>")
vim.keymap.set("n", "<leader><Down>", ":resize -10<cr>")
vim.keymap.set("n", "<leader><Left>", ":vertical resize +10<cr>")
vim.keymap.set("n", "<leader><Right>", ":vertical resize -10<cr>")

-- Quickfix list
vim.keymap.set("n", "<leader>n", ":cnext<cr>")
vim.keymap.set("n", "<leader>N", ":cp<cr>")

--fancy block mover
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv")

-- LSP related keymappings

vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<leader>gi", "<cmd> vim.lsp.buf.implementation()<CR>")
vim.keymap.set("n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set(
  "n",
  "<leader>gf",
  "<cmd>lua require('telescope.builtin').lsp_references({show_line = false})<CR>"
)
vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async: true })<CR>")
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<C>")
vim.keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float: true })<CR>")
vim.keymap.set("n", "[g", "<cmd>lua vim.diagnostic.open_float({ float: true })<CR>")

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
-- vim.keymap.set("n", "<leader>h", function()
--   require("telescope.builtin").help_tags(opts)
-- end)
vim.keymap.set("n", "<leader>*", function()
  require("telescope.builtin").grep_string(opts)
end)

--vim.keymap.set("n", '<leader>"', "<cmd>Telescope registers<CR>")
--
vim.keymap.set("n", '<leader>"', function()
  require("telescope.builtin").registers(opts)
end)

-- Formatting
vim.keymap.set("n", "<leader>,", "<cmd>lua vim.lsp.buf.format()<CR>")

-- Oil
vim.keymap.set("n", "<leader><Tab>", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader><leader><Tab>", function()
  vim.cmd([[vs]])
  require("Navigator").left()
  vim.cmd([[Oil]])
end, { desc = "Open oil in split" })



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
	vim.cmd([[function 'normal di[']])
	vim.cmd([[startinsert]])
end)
vim.keymap.set("n", "sr", function()
	require("hop").hint_char2()
	vim.cmd([[execute 'normal viwp']])
	vim.cmd([[startinsert]])
end)
vim.keymap.set("n", "s*", function()
	vim.cmd([[execute 'normal yiw']])
	require("hop").hint_char2()
	vim.cmd([[execute 'normal viwp']])
	vim.cmd([[startinsert]])
end)

-- Fugutive
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
vim.keymap.set("n", "<leader>gw", "<cmd>Git commit<CR>")

-- Diagnostics
vim.keymap.set("n", "g?", vim.diagnostic.open_float)
vim.keymap.set("n", "g[", vim.diagnostic.goto_next)
vim.keymap.set("n", "g]", vim.diagnostic.goto_prev)

-- Substitution
vim.keymap.set("n", "<leader>s", ":%s/<c-r><c-w>/")
vim.keymap.set("n", "<leader>sl", "yiwV:s/<c-r>0/")

-- Clear hightlights
vim.keymap.set("n", "<leader>l", ":nohl<cr>")

-- Debugging
-- vim.keymap.set("n", "<leader>dc", require("dap").continue)
-- vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint)
-- vim.keymap.set("n", "<leader>du", require("dapui").toggle)

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<leader>hh", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "gj", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "gk", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "gl", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "g;", function()
  harpoon:list():select(4)
end)

harpoon:extend({
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-v>", function()
      harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-x>", function()
      harpoon.ui:select_menu_item({ split = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-t>", function()
      harpoon.ui:select_menu_item({ tabedit = true })
    end, { buffer = cx.bufnr })
  end,
})
-- -- UndoTree
-- vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
