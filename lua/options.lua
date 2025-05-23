-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.swapfile = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Misc
vim.opt.shiftwidth = 4
vim.opt.linespace = 8
vim.opt.signcolumn = 'yes:1'
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#ffffff' }) -- Make absolute line numbers white
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffffff', bold = true }) -- Make current line number white and bold

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true

-- Keep some space around cursor to reduce visual overwhelm
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- Enable code folding with syntax awareness
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldlevel = 2
-- vim.opt.foldenable = true
--
-- Autocmds

vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  command = 'checktime',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  command = 'set formatoptions-=cro',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.fn.expand '$MYVIMRC',
  command = 'source $MYVIMRC',
  desc = 'Reload Neovim config on save',
})

-- Basic vim options
vim.opt.cursorline = true -- Highlight the current line
vim.opt.showmatch = true -- Show matching brackets
vim.opt.relativenumber = true -- Relative line numbers help with movement

-- Add visual aids for indentation
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  extends = '›',
  precedes = '‹',
  nbsp = '·',
  trail = '·',
}
-- vim: ts=2 sts=2 sw=2 et
