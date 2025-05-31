return {
  "karb94/neoscroll.nvim",
  enabled = function()
    -- Disable if NVIM_SSHFS is set in the environment
    return os.getenv("NVIM_SSHFS") ~= "1"
  end,
  config = function()
    require("neoscroll").setup({
      hide_cursor = true,
      respect_scrolloff = true,
      easing_function = "quadratic",
      stop_eof = true, 
    })
  end,
}