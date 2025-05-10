return {
  {
    'Mofiqul/vscode.nvim',
    lazy = false, -- We want the colorscheme to load immediately
    priority = 1000, -- Load this before other plugins
    config = function()
      -- Enable transparent background
      require('vscode').setup {
        -- Enable italic comments
        italic_comments = true,
        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,
        -- Override colors (optional)
        color_overrides = {
          vscLineNumber = '#FFFFFF',
        },
      }

      -- Set colorscheme
      vim.cmd.colorscheme 'vscode'
    end,
  },
}
