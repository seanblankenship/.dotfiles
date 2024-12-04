return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup({
      options = {
        separator_style = "padded_slope",
        hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
        },
        indicator = {
          style = "underline",
        },
        numbers = function(opts)
          return string.format('%s%s', opts.raise(opts.ordinal), opts.id)
        end,
      },
    })
  end
}
