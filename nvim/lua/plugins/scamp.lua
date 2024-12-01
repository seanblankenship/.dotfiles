return {
  "nat-418/scamp.nvim",
  config = function()
    require('scamp').setup({
      -- see man(5) ssh_config for more control options
      scp_options = {
        'ConnectTimeout=5'
      }
    })
  end
}
