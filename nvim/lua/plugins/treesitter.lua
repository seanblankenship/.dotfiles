return {
  "nvim-treesitter/nvim-treesitter", 
  build=":TSUpdate", 
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "bash",
        "css",
        "csv",
        "dockerfile",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "nginx",
        "php",
        "python",
        "scss",
        "sql",
        "ssh_config",
        "templ",
        "tmux",
        "toml",
        "typescript",
        "xml",
        "yaml"
      },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}
