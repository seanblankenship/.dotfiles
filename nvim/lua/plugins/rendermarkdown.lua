return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
  ft = { "markdown" },
  config = function()
    require("render-markdown").setup({
      icons = {
        bullet = "•",
        list = "‣",
        heading = {
          h1 = "󰉫",
          h2 = "󰉬",
          h3 = "󰉭",
          h4 = "󰉮",
          h5 = "󰉯",
          h6 = "󰉰",
        },
      },
      highlights = {
        heading = "Title",
        bullet = "Special",
        code = "String",
        italic = "Italic",
        bold = "Bold",
        strikethrough = "Comment",
      },
    })
  end
}