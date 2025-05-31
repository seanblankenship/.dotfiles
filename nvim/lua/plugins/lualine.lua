return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 200,
        },
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'buffers'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress', 'location'},
        lualine_z = {
          { 'diagnostics',
            sources = {'nvim_lsp'},
            sections = {'error', 'warn', 'info', 'hint'},
            diagnostics_color = {
              error = 'DiagnosticError',
              warn  = 'DiagnosticWarn',
              info  = 'DiagnosticInfo',
              hint  = 'DiagnosticHint',
            },
            symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
    }
  end
}