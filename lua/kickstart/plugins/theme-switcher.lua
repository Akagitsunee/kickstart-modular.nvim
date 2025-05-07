local M = {}

local state = { themes = {}, current_idx = 1 }

-- Apply transparency to common highlight groups
local function set_transparent(enable)
  local bg = enable and 'NONE' or nil
  local groups = {
    'Normal',
    'NormalFloat',
    'SignColumn',
    'NormalNC',
    'LineNr',
    'Folded',
    'NonText',
    'SpecialKey',
    'VertSplit',
    'EndOfBuffer',
  }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = bg })
  end
end

-- Switch to a specific theme
local function switch_theme(theme_name)
  local ok = pcall(vim.cmd.colorscheme, theme_name)
  if ok then
    vim.g.transparent_enabled = vim.g.transparent_enabled or false
    if vim.g.transparent_enabled then
      set_transparent(true)
    end
    return true
  end
  return false
end

-- Theme selector window
function M.list_themes()
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set up the window
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = 30,
    height = #state.themes + 2,
    row = math.floor((vim.o.lines - (#state.themes + 2)) / 2),
    col = math.floor((vim.o.columns - 30) / 2),
    style = 'minimal',
    border = 'rounded',
  })

  -- Set content
  local lines = { 'Select theme (1-9, t for transparency):' }
  for i, theme in ipairs(state.themes) do
    local current = theme == vim.g.colors_name and '* ' or string.format('%d ', i)
    table.insert(lines, string.format('%s%s', current, theme))
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = 'nofile'

  -- Keymaps
  local opts = { buffer = buf, silent = true }
  vim.keymap.set('n', 'q', '<cmd>close<CR>', opts)
  vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', opts)
  vim.keymap.set('n', 't', function()
    M.toggle_transparency()
    vim.cmd 'close'
  end, opts)

  -- Number keys for selection
  for i = 1, math.min(9, #state.themes) do
    vim.keymap.set('n', tostring(i), function()
      if switch_theme(state.themes[i]) then
        state.current_idx = i
      end
      vim.cmd 'close'
    end, opts)
  end
end

-- Rotate through themes
function M.rotate_theme()
  state.current_idx = state.current_idx % #state.themes + 1
  switch_theme(state.themes[state.current_idx])
end

-- Toggle transparency
function M.toggle_transparency()
  vim.g.transparent_enabled = not vim.g.transparent_enabled
  set_transparent(vim.g.transparent_enabled)
end

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

-- Setup
function M.setup()
  vim.keymap.set('n', '<leader>cl', M.list_themes, { desc = 'List themes' })
  vim.keymap.set('n', '<leader>cn', M.rotate_theme, { desc = 'Next theme' })
  vim.keymap.set('n', '<leader>bg', M.toggle_transparency, { desc = 'Toggle transparency' })
end

return M
