return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        eunsure_installed = { "lua_ls", "ts_ls", "intelephense", "html", "emmet_language_server"}
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require ("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.intelephense.setup({
        root_dir = function()
          return vim.fn.expand '$HOME'
        end,
        -- root_dir = function(pattern)
        --   — Add wp-config to root-dir
        --   local cwd = vim.loop.cwd()
        --   local util = require ‘lspconfig.util’
        --   local root = util.root_pattern(‘composer.json’, ‘.git’, ‘wp-config.php’)(pattern)
        --
        --   — prefer cwd if root is a descendant
        --   return util.path.is_descendant(cwd, root) and cwd or root
        -- end,
        settings = {

          intelephense = {
            -- stubs = {
            --   'wordpress',
            --   'wordpress-stubs',
            --   'acf-pro-stubs',
            -- },
            environment = {
              shortOpenTag = true,
              -- includePaths = {
              --   require('lspconfig.util').path.join(vim.fn.stdpath 'data', 'mason', 'bin'),
              --   '~/.config/composer/vendor/php-stubs/*',
              -- },
            },
          },
        },
      })
      lspconfig.html.setup({})
      lspconfig.emmet_language_server.setup({
        filetypes = { "php", "css", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, {})
      vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    end,
  },
}
