return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'darker',
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
    vim.cmd.colorscheme 'onedark'
  end,
}
