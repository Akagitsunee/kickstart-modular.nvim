return {
  'rose-pine/neovim',
  name = 'rose-pine',
  config = function(opts)
    require('rose-pine').setup {
      dim_inactive_windows = true,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },
      styles = {
        transparency = false,
      },
    }
    vim.cmd 'colorscheme rose-pine'
  end,
}
