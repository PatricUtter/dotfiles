-- Treesitter
require("nvim-treesitter.configs").setup({
	auto_install = false,
	-- don't want to install every time. enoyin
	-- ensure_installed = {
	-- 	"bash",
	-- 	"css",
	-- 	"dockerfile",
	-- 	"git_rebase",
	-- 	"gitattributes",
	-- 	"gitcommit",
	-- 	--"gitignore", -- look at auto adding tre sitter cli so that we can have these in here
	-- 	--"sql",
	-- 	"html",
	-- 	"http",
	-- 	"java",
	-- 	"javascript",
	-- 	"jq",
	-- 	"jsdoc",
	-- 	"json",
	-- 	"json5",
	-- 	"jsonnet",
	-- 	"lua",
	-- 	"make",
	-- 	"markdown",
	-- 	"markdown_inline",
	-- 	"rust",
	-- 	"scss",
	-- 	"toml",
	-- 	"tsx",
	-- 	"typescript",
	-- 	"vim",
	-- 	"yaml",
	-- },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
