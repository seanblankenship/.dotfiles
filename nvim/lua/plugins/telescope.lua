return {
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>t", builtin.find_files, {})
      vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>b", function() builtin.buffers({
        sort_mru = true,
        ignore_current_buffer = true,
      }) end)
      vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup ({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },
}
