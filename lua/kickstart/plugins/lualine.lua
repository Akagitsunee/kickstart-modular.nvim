return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'

    local icons = require 'kickstart.plugins.misc.icons'

    -- Define custom conditions for lualine sections
    local section_b_cond = {
      function()
        return vim.o.columns >= 95
      end,
      function()
        return vim.o.columns >= 115
      end,
    }

    -- Lualine configuration
    lualine.setup {
      options = {
        globalstatus = vim.o.laststatus == 3, -- Enable global statusline
        component_separators = '',
        section_separators = { left = '', right = '' },
        disabled_filetypes = { statusline = {}, winbar = {} },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {
          {
            'mode',
            icon = icons.neovim,
            separator = { left = '', right = '' },
            padding = { left = 1, right = 0 },
          },
        },
        lualine_b = {
          { 'branch', icon = icons.git.branch, cond = section_b_cond[1] },
          {
            'diff',
            symbols = {
              added = icons.git.diff.added .. ' ',
              modified = icons.git.diff.modified .. ' ',
              removed = icons.git.diff.removed .. ' ',
            },
            padding = { left = 0, right = 1 },
            cond = section_b_cond[2],
          },
        },
        lualine_c = {
          { '%=', padding = 0 }, -- Center align components
          {
            'datetime',
            icon = icons.clock,
            style = '%H:%M',
            separator = { left = '', right = '' },
            padding = 0,
          },
        },
        lualine_x = {}, -- Empty section for customization
        lualine_y = {
          {
            'filetype',
            fmt = string.upper,
            cond = section_b_cond[1],
          },
          -- {
          --   function()
          --     return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
          --   end,
          --   icon = { icons.directory, color = 'Directory' },
          --   cond = section_b_cond[2],
          -- },
          { 'filename' },
        },
        lualine_z = {
          {
            'location',
            separator = { left = '', right = '' },
            padding = { left = 0, right = 1 },
          },
        },
      },
      inactive_sections = { -- Define inactive sections
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename' } },
        lualine_x = { { 'location' } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
    }

    -- Additional Vim options for statusline
    vim.opt.showmode = false
    vim.opt.fillchars = vim.tbl_extend('force', vim.opt.fillchars:get(), {
      stl = '━',
      stlnc = '━',
    })
  end,
}
