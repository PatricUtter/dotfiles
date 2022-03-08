vim.g.mapleader = ' '

local function map (from, to, mode) 
    local opts = {noremap = true, silent = true}
    mode = mode or 'n'
    vim.api.nvim_set_keymap(mode, from, to, opts)
end

-- Try to live without this
-- map('ii', '<Esc>', 'i')
map('kj', '<Esc>', 'i')
map('jk', '<Esc>', 'i')

map('<C-h>', '<C-w>h')
map('<C-j>', '<C-w>j')
map('<C-k>', '<C-w>k')
map('<C-l>', '<C-w>l')

map('<leader>p', '"+p', 'x')
map('<leader>p', '"+p', 'n')
map('<leader>y', '"+y', 'x')

--fancy block mover
map('K', ":move \'<-2<CR>gv-gv", 'v')
map('J', ":move \'>+1<CR>gv-gv", 'v')
