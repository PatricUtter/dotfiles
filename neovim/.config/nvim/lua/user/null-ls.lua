--
-- Null ls
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.prettier.with({
			filetypes = { "typescript", "javascript", "html", "markdown" },
		}),
		--Works but is a bit slow and
		-- require("null-ls").builtins.diagnostics.eslint.with({
		-- 	filetypes = { "typescript", "javascript" },
		-- }),
		require("null-ls").builtins.formatting.stylua.with({
			filetypes = { "lua" },
		}),
		require("null-ls").builtins.code_actions.gitsigns.with({
			filetypes = { "typescript", "lua" },
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
