-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {
        diagnostic = {
          show_code_action = false,
          max_width = 80,
          max_height = 10,
          show_layout = 'float', -- or "normal" if float is too annoying
          border_follow = false,
          border_style = 'rounded',
          extend_relatedInformation = false, -- turn off extra type noise
        },
        ui = {
          border = 'rounded',
        },
      }
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- icons
      'nvim-treesitter/nvim-treesitter', -- for code parsing (not strictly required but recommended)
    },
  },
}
