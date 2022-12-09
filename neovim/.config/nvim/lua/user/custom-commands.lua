local sourceFile = os.getenv("NVIM_SOURCE_FILE")

if sourceFile ~= nil then
	vim.api.nvim_create_user_command("SourceMe", function()
		vim.cmd("luafile " .. sourceFile)
		print("Config sourced")
	end, {})
end

vim.api.nvim_create_user_command("CleanLog", function()
	vim.cmd([[g!/{"/d]])
	vim.cmd([[set ft=json]])
	vim.cmd([[%s/\\n\\/\r/g]])
	vim.cmd([[/error]])
	print("Logs are clean")
end, {})

vim.api.nvim_create_user_command("ReplaceNewLines", function()
	vim.cmd([[%s/\\n\\/\r/g]])
	print("Newlines are now new lines")
end, {})
