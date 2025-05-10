local M = {}

local state = { themes = {}, current_idx = 3 }

-- Get plugin specs for lazy.nvim
function M.get_plugin_specs()
  local themes_dir = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':h') .. '/themes'
  local specs = {}

  for file in vim.fs.dir(themes_dir) do
    if file:match '%.lua$' then
      local theme = dofile(themes_dir .. '/' .. file)
      if theme then
        table.insert(specs, theme)
      end
      table.insert(state.themes, vim.fn.fnamemodify(file, ':r'))
    end
  end

  return specs
end

return M
