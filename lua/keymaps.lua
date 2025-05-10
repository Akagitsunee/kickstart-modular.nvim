-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
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

-- Disable arrow keys in Normal mode
vim.keymap.set('n', '<Up>', '<Nop>', { desc = 'No operation (force hjkl)' })
vim.keymap.set('n', '<Down>', '<Nop>', { desc = 'No operation (force hjkl)' })
vim.keymap.set('n', '<Left>', '<Nop>', { desc = 'No operation (force hjkl)' })
vim.keymap.set('n', '<Right>', '<Nop>', { desc = 'No operation (force hjkl)' })

-- Custom keymaps
--
--Baisc Actions
vim.keymap.set('n', '<leader>w', ':w <CR>', { desc = 'Write' })

-- Make escaping insert mode possible with CTRL-C
vim.keymap.set('i', '<C-c>', '<Esc>')
-- Don't copy deleted text with 'x' or 'd' in normal and visual mode

vim.keymap.set('n', '<leader>sa', 'ggVG', { desc = 'Select all' })
vim.keymap.set('n', '<leader>pa', 'ggVGp', { desc = 'Select all and paste' })

vim.keymap.set({ 'n', 'v' }, 'x', [["_x]])
vim.keymap.set({ 'n', 'v' }, 'd', [["_d]])
vim.keymap.set('n', '<leader>P', 'o<Esc>O<Esc>p')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })
-- Oil
vim.keymap.set('n', '<leader>oi', ':Oil <CR>', { desc = 'Open Oil' })
vim.keymap.set('n', '<leader>z', ':ZenMode <CR>', { desc = 'Toggle Zen' })
-- Misc
vim.keymap.set('n', 't', ':TransparentToggle <CR>', { desc = 'Toggle Transparancy' })
vim.keymap.set('n', '<leader>tt', ':SwitchColorscheme <CR>', { desc = 'Change Colorscheme' })

vim.keymap.set('n', '<leader>to', function()
  vim.opt.scrolloff = 999 - vim.o.scrolloff
end, { desc = 'Toggle center cursor' })
-- vim: ts=2 sts=2 sw=2 et
