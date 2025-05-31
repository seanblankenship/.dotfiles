return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        bufferline = true,
        cmp = true,
        gitsigns = true,
        lsp_trouble = true,
        mason = true,
        neotree = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    })
    vim.cmd.colorscheme "catppuccin"
  end
}