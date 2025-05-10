return {
  'rcarriga/nvim-notify',
  lazy = false, -- load it immediately
  config = function()
    local notify = require 'notify'
    notify.setup {
      -- optional config here
      stages = 'fade_in_slide_out',
      render = 'default',
      timeout = 3000,
      background_colour = '#000000',
    }

    vim.notify = notify -- 🔥 this sets it globally
  end,
}
