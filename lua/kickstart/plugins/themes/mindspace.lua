return {
  'Akagitsunee/mindspace.nvim',
  lazy = false, -- Changed from true to false
  priority = 1000,
  config = function()
    require('mindspace').load()
  end,
}
