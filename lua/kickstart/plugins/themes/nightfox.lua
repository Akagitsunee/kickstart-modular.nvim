-- in your plugins/lazy.lua or wherever you setup lazy.nvim plugins

return {
  {
    'EdenEast/nightfox.nvim',
    config = function()
      require('nightfox').setup {
        options = {
          variant = 'carbonfox', -- set the variant here
        },
      }
      vim.cmd 'colorscheme carbonfox'
    end,
  },
  -- other plugins ...
}
