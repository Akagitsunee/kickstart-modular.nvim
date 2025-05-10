return {
  'Shatur/neovim-ayu',
  name = 'ayu',
  config = function()
    require('ayu').setup {
      dark = true, -- Set to false for "light" variant
      terminal = true,
      -- overrides = {
      --   Normal = { bg = 'None' },
      --   NormalFloat = { bg = 'none' },
      --   ColorColumn = { bg = 'None' },
      --   SignColumn = { bg = 'None' },
      --   Folded = { bg = 'None' },
      --   FoldColumn = { bg = 'None' },
      --   CursorLine = { bg = 'None' },
      --   CursorColumn = { bg = 'None' },
      --   VertSplit = { bg = 'None' },
      -- },
    }
    vim.cmd 'colorscheme ayu'
  end,
}
