-- Telescope
require("telescope").load_extension("fzf")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-q>"] = function(buf)
          require("telescope.actions").send_selected_to_qflist(buf)
          require("telescope.actions").open_qflist(buf)
        end,
        ["<C-m>"] = function(buf)
          require("telescope.actions").select_all(buf)
          require("telescope.actions").send_selected_to_qflist(buf)
          require("telescope.actions").open_qflist(buf)
        end
        --require("telescope.actions").open_qflist()
        -- ["<C-a>"] = require("telescope.actions").select_all,
      },
    },
    path_display = { "truncate" },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})

require("telescope").load_extension("ui-select")
