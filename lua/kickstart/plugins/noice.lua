return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function()
    require('noice').setup {
      lsp = {
        -- override markdown rendering so that cmp and other plugins use Treesitter
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages go to split
        inc_rename = false, -- enable inc-rename dialog (requires inc-rename plugin)
        lsp_doc_border = false, -- border on hover/signature help
      },
    }

    -- optional: set notify globally (for nicer notifications)
    local notify = require 'notify'
    notify.setup { timeout = 3000 }
    vim.notify = notify
  end,
}
