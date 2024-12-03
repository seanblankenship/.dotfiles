local sass_watchers = {}

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.scss",
  callback = function(args)
    local filepath = args.file
    local dirname = vim.fn.fnamemodify(filepath, ":p:h")
    local filename = vim.fn.fnamemodify(filepath, ":t:r") -- Filename without extension
    local css_output = dirname .. "/" .. filename .. ".css"

    -- Start watching the file
    local job_id = vim.fn.jobstart({
      "sass",
      "--watch",
      filepath .. ":" .. css_output,
      "--style",
      "compressed",
    }, { detach = true })

    if job_id > 0 then
      sass_watchers[filepath] = job_id
      print("Started watching: " .. filepath)
    else
      print("Failed to start Sass watcher for: " .. filepath)
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*.scss",
  callback = function(args)
    local filepath = args.file
    local dirname = vim.fn.fnamemodify(filepath, ":p:h")
    local filename = vim.fn.fnamemodify(filepath, ":t:r") -- Filename without extension
    local css_output = dirname .. "/" .. filename .. ".css"

    -- Compile manually on save
    vim.fn.system({
      "sass",
      filepath .. ":" .. css_output,
      "--style",
      "compressed",
    })
    print("Compiled " .. filepath .. " to " .. css_output)
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "BufUnload" }, {
  pattern = "*.scss",
  callback = function(args)
    local filepath = args.file

    -- Stop watching the file
    local job_id = sass_watchers[filepath]
    if job_id then
      vim.fn.jobstop(job_id)
      sass_watchers[filepath] = nil
      print("Stopped watching: " .. filepath)
    end
  end,
})
