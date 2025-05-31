return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.icons').setup({
      default = { icon = "" },
      directory = { icon = "" },
      extension = {
        txt  = { icon = "" },
        lua  = { icon = "" },
        py   = { icon = "" },
        js   = { icon = "" },
        html = { icon = "" },
        css  = { icon = "" },
      },
      file = {
        lua      = { icon = "" },
        python   = { icon = "" },
        markdown = { icon = "" },
        json     = { icon = "" },
        yaml     = { icon = "ﯧ" },
      },
      filetype = {
        lua        = { icon = "" },
        python     = { icon = "" },
        javascript = { icon = "" },
        html       = { icon = "" },
        css        = { icon = "" },
        markdown   = { icon = "" },
      },
      lsp = {
        Text          = { icon = "" },
        Method        = { icon = "ƒ" },
        Function      = { icon = "" },
        Constructor   = { icon = "" },
        Field         = { icon = "" },
        Variable      = { icon = "" },
        Class         = { icon = "" },
        Interface     = { icon = "ﰮ" },
        Module        = { icon = "" },
        Property      = { icon = "" },
        Unit          = { icon = "" },
        Value         = { icon = "" },
        Enum          = { icon = "" },
        EnumMember    = { icon = "" },
        Constant      = { icon = "" },
        Struct        = { icon = "פּ" },
        Event         = { icon = "" },
        Operator      = { icon = "" },
        TypeParameter = { icon = "" },
      },
      os = {
        unix    = { icon = "" },
        windows = { icon = "犯" },
        mac     = { icon = "" },
      },
    })

    -- Optional: disable this if you're using LSP-based completion
    -- require("mini.completion").setup()

    require("mini.align").setup()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.indentscope").setup()
    vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#74c7ec', nocombine = true })
  end
}