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
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html", 
          "intelephense",
          "cssls",
          "emmet_language_server",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    enabled = function()
      return os.getenv("NVIM_SSHFS") ~= "1"
    end,
    config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

      -- TypeScript / JavaScript
      lspconfig.ts_ls.setup({})

      -- HTML
      lspconfig.html.setup({})

      -- CSS and SCSS
      lspconfig.cssls.setup({
        filetypes = { "css", "scss", "less" },
      })

      -- PHP
      lspconfig.intelephense.setup({
        root_dir = util.root_pattern("composer.json", ".git", "wp-config.php"),
        settings = {
          intelephense = {
            environment = {
              shortOpenTag = true,
            },
          },
        },
      })

      -- Emmet for HTML/PHP/CSS
      lspconfig.emmet_language_server.setup({
        filetypes = {
          "php",
          "css",
          "scss",
          "html",
          "javascript",
          "javascriptreact",
          "typescriptreact",
          "vue",
        },
      })

      -- Lua
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- LSP Keymaps (global)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    end,
  },
}