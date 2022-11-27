require("mason").setup()
require("mason-lspconfig").setup()

local function global_on_attach(_, bufnr)
  local opts = { noremap = true, silent = true }

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd> vim.lsp.buf.implementation()<CR>", opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gf', '<cmd> lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gf", "<cmd>Telescope lsp_references<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async: true })<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float: true })<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", "<cmd>lua vim.diagnostic.open_float({ float: true })<CR>", opts)
end

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
      on_attach = global_on_attach,
    })
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["tsserver"] = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    require("typescript").setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false, -- enable debug logging for commands
      go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
      },
      server = { -- pass options to lspconfig's setup method
        capabilities = capabilities,
        on_attach = global_on_attach,
      },
    })
  end,
  ["sumneko_lua"] = function()
    require("lspconfig")["sumneko_lua"].setup({
      on_attach = global_on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "use" },
          },
        },
      },
    })
  end,
  ["jdtls"] = function()
    --do nothing here since it's handled in separate file
  end,
})
