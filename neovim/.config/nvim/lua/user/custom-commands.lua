local sourceFile = os.getenv("NVIM_SOURCE_FILE")

if sourceFile ~= nil then
	vim.api.nvim_create_user_command("SourceMe", function()
		vim.cmd("source " .. sourceFile)
		print("Config sourced")
	end, {})
end

vim.api.nvim_create_user_command("ReplaceNewLines", function()
	vim.cmd([[%s/\\n/\r/g]])
	print("Newlines are now new lines")
end, {})

vim.api.nvim_create_user_command("CleanLog", function()
	vim.cmd([[set ft=json]])
	vim.cmd([[%!jq .]])
	vim.cmd([[%s/\\n/\r/g]])
	vim.cmd([[%s/\\t/\r/g]])
	vim.cmd([[g/^$/d]])
end, {})

vim.api.nvim_create_user_command("TStypecheck", function()
	require("user.ts-typecheck").typecheck()
end, {})

vim.api.nvim_create_user_command("NewMComp", function()
	vim.cmd([[:r ~/Templates/mcomp]])
	vim.cmd([[:normal 4jfNciw]])
end, {})

vim.api.nvim_create_user_command("NewMFComp", function()
	vim.cmd([[:r ~/Templates/mfcomp]])
	vim.cmd([[:normal 4jfNciw]])
end, {})

-- tsc error to quickfix
--
vim.cmd([[
  augroup TSCERRORQUICKFIX
    autocmd FileType typescript,typescriptreact set makeprg=./node_modules/.bin/tsc\ \\\|\ sed\ 's/(\\(.*\\),\\(.*\\)):/:\\1:\\2:/'
  augroup END
]])
