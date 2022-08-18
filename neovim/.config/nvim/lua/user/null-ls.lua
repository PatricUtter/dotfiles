-- Null ls
require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.code_actions.gitsigns,
	},
	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async:true})
            augroup END
            ]])
		end
	end,
})

