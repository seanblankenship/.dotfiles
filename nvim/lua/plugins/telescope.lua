return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make", -- This compiles the native extension
    },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", "%.git/" },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown { previewer = false },
        },
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case", "respect_case"
        },
      },
    })

    telescope.load_extension("ui-select")
    telescope.load_extension("fzf")

    vim.keymap.set("n", "<leader>t", builtin.find_files, {})
    vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>b", function()
      builtin.buffers({
        sort_mru = true,
        ignore_current_buffer = true,
      })
    end)
    vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})
  end,
}