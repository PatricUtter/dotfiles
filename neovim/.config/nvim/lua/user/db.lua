vim.g.db_ui_save_location = "~/.config/db_ui"
vim.cmd(
	[[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
)
