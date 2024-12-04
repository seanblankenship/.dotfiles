return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.icons').setup({
      config = {
        default = "",  -- Generic file icon (can be replaced with any icon)
        directory = "",  -- Folder icon
        extension = {
          txt = "",  -- Text files
          lua = "",  -- Lua files
          py = "",   -- Python files
          js = "",   -- JavaScript files
          html = "", -- HTML files
          css = "",  -- CSS files
        },
        file = {
          default = "",  -- Default icon for files
          lua = "",      -- Lua files
          python = "",   -- Python files
          markdown = "", -- Markdown files
          json = "",     -- JSON files
          yaml = "ﯧ",     -- YAML files
        },
        filetype = {
          lua = "",      -- Lua
          python = "",   -- Python
          javascript = "", -- JavaScript
          html = "",     -- HTML
          css = "",      -- CSS
          markdown = "", -- Markdown
        },
        lsp = {
          Text = "",    -- Text
          Method = "ƒ",  -- Method
          Function = "", -- Function
          Constructor = "", -- Constructor
          Field = "",   -- Field
          Variable = "", -- Variable
          Class = "",   -- Class
          Interface = "ﰮ", -- Interface
          Module = "",  -- Module
          Property = "", -- Property
          Unit = "",    -- Unit
          Value = "",   -- Value
          Enum = "",    -- Enum
          EnumMember = "", -- Enum Member
          Constant = "",  -- Constant
          Struct = "פּ",   -- Struct
          Event = "",    -- Event
          Operator = "", -- Operator
          TypeParameter = "", -- Type Parameter
        },
        os = {
          unix = "",    -- Unix icon
          windows = "犯", -- Windows icon
          mac = "",     -- macOS icon
        },
      },
    })
    require("mini.completion").setup()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.indentscope").setup()
    vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#74c7ec', nocombine = true })
  end
}
