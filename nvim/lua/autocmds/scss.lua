vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.scss",
  callback = function(args)
    local filepath = args.file
    local filename = vim.fn.fnamemodify(filepath, ":t:r")
    local dirname = vim.fn.fnamemodify(filepath, ":p:h")
    local css_output = dirname .. "/" .. filename .. ".css"
    local result = vim.fn.system({
      "sass",
      filepath .. ":" .. css_output,
      "--style=compressed",
      "--no-source-map",
    })
    if vim.v.shell_error ~= 0 then
      vim.notify("Sass compile failed:\n" .. result, vim.log.levels.ERROR)
    else
      vim.notify("Compiled SCSS → " .. filename .. ".css", vim.log.levels.INFO)
    end
  end,
})
