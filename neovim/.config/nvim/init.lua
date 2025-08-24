require("config.lazy")
require('settings')
require('keymappings')

-- lsp setup
require('setup.lsp.luals')
require('setup.lsp.typescript')
require('setup.lsp.bashls')
require('setup.lsp.go')
require('setup.lsp.docker')
require('setup.lsp.python')
require('setup.lsp.yaml')
require('setup.lsp.json')

-- plugin setups
require('setup.telescope')
require('setup.blink')
require('setup.treesitter')

