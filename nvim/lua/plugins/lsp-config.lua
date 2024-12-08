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
        eunsure_installed = { "lua_ls", "ts_ls", "intelephense", "html", "goimports", "gofumpt", "gomodifytags", "impl", "delve"}
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require ("lspconfig")

      -- emmet
      lspconfig.emmet_language_server.setup({
        filetypes = { "php", "css", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
      })

      -- go
      lspconfig.gopls.setup({
        servers = {
          gopls = {
            settings = {
              gopls = {
                gofumpt = true,
                codelenses = {
                  gc_details = false,
                  generate = true,
                  regenerate_cgo = true,
                  run_govulncheck = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
                analyses = {
                  fieldalignment = true,
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = true,
              },
            },
          },
        },
        setup = {
          gopls = function(_, opts)
            -- workaround for gopls not supporting semanticTokensProvider
            -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
            LazyVim.lsp.on_attach(function(client, _)
              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end, "gopls")
            -- end workaround
          end,
        },
      })

      -- html
      lspconfig.html.setup({})

      -- lua
      lspconfig.lua_ls.setup({})

      -- php
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

      -- typescript
      lspconfig.ts_ls.setup({})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, {})
      vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    end,
  },
}
