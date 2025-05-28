return {
  'Akagitsunee/mindspace.nvim',
  lazy = true, -- Changed from true to false
  priority = 1000,
  config = function()
    require('mindspace').load()
  end,
}
