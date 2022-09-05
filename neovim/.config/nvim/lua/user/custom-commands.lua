local sourceFile = os.getenv("NVIM_SOURCE_FILE")

if sourceFile ~= nil then
	print(sourceFile)
	vim.api.nvim_create_user_command("SourceMe", function()
		vim.cmd("source " .. sourceFile)
	end, {})
end
