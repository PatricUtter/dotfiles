require("dap-vscode-js").setup({
	node_path = "/home/utter/.nvm/versions/node/v18.0.0/bin/node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	debugger_path = "/home/utter/.local/share/nvim/mason/packages/js-debug-adapter", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "launch file",
			program = "${file}",
			cwd = "${workspacefolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "attach",
			processid = require("dap.utils").pick_process,
			cwd = "${workspacefolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			-- trace = true, -- include debugger info
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/jest/bin/jest.js",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
	}
end
