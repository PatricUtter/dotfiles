vim.g.db_ui_save_location = "~/.config/db_ui"
vim.g.db_ui_execute_on_save = 0
vim.g.db_ui_show_database_icon = 1

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "*.sql", "*.mysql", "*.plsql" },
	callback = function()
		-- doesn't seem like this is working ?
		vim.g.compe.source.vim_dadbod_completion = true
		require("cpm").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
	end,
})
