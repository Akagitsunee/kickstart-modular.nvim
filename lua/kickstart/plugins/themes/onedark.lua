return {
  'navarasu/onedark.nvim',
  lazy = true,
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'dark',
      code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
      },
      diagnostics = {
        darker = true,
        undercurl = true,
        background = false,
      },
    }
    require('onedark').load()
  end,
}
