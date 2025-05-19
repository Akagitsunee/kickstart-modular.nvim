return {
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {
        diagnostic = {
          show_code_action = true,
          show_source = true,
          jump_num_shortcut = true,
          max_width = 60,
          max_height = 10,
          text_hl_follow = true,
          border_follow = true,
          extend_relatedInformation = true,
          show_layout = 'float',
          keys = {
            exec_action = 'o',
            quit = 'q',
            toggle_or_jump = '<CR>',
          },
        },
        ui = {
          border = 'rounded',
          colors = {
            normal_bg = '#1a1b26',
          },
          kind = require('catppuccin.groups.integrations.lsp_saga').custom_kind(),
        },
        lightbulb = {
          enable = true,
          sign = true,
          virtual_text = false,
        },
      }
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
