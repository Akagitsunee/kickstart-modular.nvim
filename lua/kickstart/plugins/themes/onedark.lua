return {
  'navarasu/onedark.nvim',
  lazy = true,
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'warm',
      diagnostics = {
        darker = true,
        undercurl = true,
        background = false,
      },
    }
    require('onedark').load()
  end,
}
