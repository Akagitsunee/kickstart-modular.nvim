-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.

local setlinecolor = function()
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#ffffff' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffffff', bold = true })
end

require('lazy').setup({
  -- Base plugins
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Core functionality by category
  require 'kickstart.plugins.ui',         -- UI enhancements and themes
  require 'kickstart.plugins.lsp',        -- LSP and debugging
  require 'kickstart.plugins.completion', -- Completion and snippets
  require 'kickstart.plugins.treesitter', -- Syntax highlighting and parsing
  require 'kickstart.plugins.git',        -- Git integration
  require 'kickstart.plugins.tools',      -- Utilities and tools
  require 'kickstart.plugins.ai',         -- AI assistance
  require 'kickstart.plugins.extras',     -- Additional utilities and learning tools

  -- NOTE: Custom plugins can be added in `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --    You can put your custom plugins in that directory
  --
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If using a Nerd Font, we can use glyphs for our icons
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  change_detection = {
    enabled = true,
    notify = true,
  },
  install = {
    missing = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {}, -- you can list unneeded stock plugins
    },
    stats = { enabled = true },
  },
})

-- vim: ts=2 sts=2 sw=2 et
