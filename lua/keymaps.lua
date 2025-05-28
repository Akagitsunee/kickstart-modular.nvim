-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Window Navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Terminal Escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit insert mode' })

-- Disable arrow keys (force hjkl)
vim.keymap.set('n', '<Up>', '<Nop>', { desc = 'No operation (force hjkl)' })
vim.keymap.set('n', '<Down>', '<Nop>', { desc = 'No operation (force hjkl)' })
vim.keymap.set('n', '<Left>', '<Nop>', { desc = 'No operation (force hjkl)' })
vim.keymap.set('n', '<Right>', '<Nop>', { desc = 'No operation (force hjkl)' })

-- File operations [f]
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- Search operations [s]
vim.keymap.set('n', '<leader>sa', 'ggVG', { desc = 'Select all' })

-- Window operations [w]
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Write' })
vim.keymap.set('n', '<leader>wq', ':wq<CR>', { desc = 'Write and Quit' })
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>wh', '<C-w>s', { desc = 'Split window horizontally' })

-- UI toggles [u]
vim.keymap.set('n', '<leader>ut', ':TransparentToggle<CR>', { desc = 'Toggle Transparency' })
vim.keymap.set({ "n"}, 't', ':TransparentToggle<CR>', { desc = 'Toggle Transparency' })
vim.keymap.set('n', '<leader>uz', ':ZenMode<CR>', { desc = 'Toggle Zen Mode' })
vim.keymap.set('n', '<leader>ul', ':Lazy<CR>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>um', ':Mason<CR>', { desc = 'Mason' })
vim.keymap.set('n', '<leader>uc', ':SwitchColorscheme<CR>', { desc = 'Change Colorscheme' })
vim.keymap.set('n', '<leader>ur', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = 'Toggle relative number' })
vim.keymap.set('n', '<leader>uo', function()
  vim.opt.scrolloff = 999 - vim.o.scrolloff
end, { desc = 'Toggle center cursor' })
vim.keymap.set('n', '<leader>uh', function()
  local buf = vim.api.nvim_get_current_buf()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
end, { desc = 'Toggle Inlay Hints' })
vim.keymap.set('n', '<leader>ue', function()
  local diagnostics_enabled = vim.diagnostic.is_disabled()
  if diagnostics_enabled then
    -- Enable only ESLint diagnostics
    vim.diagnostic.enable()
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
  else
    -- Disable all diagnostics
    vim.diagnostic.disable()
  end
end, { desc = 'Toggle ESLint Diagnostics' })

-- Code/LSP actions [c]
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Format' })
vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "CodeLens Action" })
vim.keymap.set("n", "<leader>cD", vim.lsp.buf.type_definition, { desc = "Type Definition" })
vim.keymap.set('n', '<leader>ct', function()
  local vt = vim.diagnostic.config().virtual_text
  vim.diagnostic.config { virtual_text = not vt, underline = not vt }
end, { desc = 'Toggle diagnostics' })

-- Explorer [e]
vim.keymap.set('n', '<leader>e', ':Oil<CR>', { desc = 'Open Oil' })

-- Quick actions
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true, desc = 'Hover Documentation' })
vim.keymap.set('n', '<leader>P', 'o<Esc>O<Esc>p', { desc = 'Paste with padding' })

-- Text manipulation
vim.keymap.set('n', '<leader>pa', 'ggVGp', { desc = 'Select all and paste' })
vim.keymap.set('n', '<leader>du', '0Yo<Esc>P', { desc = 'Duplicate line' })
vim.keymap.set({ 'n', 'v' }, 'x', [["_x]], { desc = 'Delete without yanking' })
vim.keymap.set({ 'n', 'v' }, 'd', [["_d]], { desc = 'Delete without yanking' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

-- [[ Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  command = 'wincmd =',
})

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- File operations [f]
local function setup_telescope_keymaps()
  local builtin = require("telescope.builtin")
  -- File operations
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
  vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent Files' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
  
  -- Search operations
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Grep' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Word' })
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help Pages' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
end

-- Setup telescope keymaps after plugin loads
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(event)
    if event.data == "telescope.nvim" then
      setup_telescope_keymaps()
    end
  end,
})

-- Non-telescope file operations
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })
vim.keymap.set('n', '<leader>sa', 'ggVG', { desc = 'Select all' })
