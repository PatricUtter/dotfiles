vim.g.db_ui_save_location = "~/.config/db_ui"
vim.g.db_ui_execute_on_save = 0
vim.g.db_ui_show_database_icon = 1

vim.cmd(
  [[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
)
