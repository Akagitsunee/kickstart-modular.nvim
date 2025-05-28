-- UI related plugins and configuration
return {
  -- Theme and colorscheme management
  { import = 'kickstart.plugins.themes' },

  -- Theme loader and switcher
  {
    'Rimkomatic/switchscheme.nvim',
    lazy = true,
    cmd = { 'SwitchColorscheme' },
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('switchscheme').setup()
    end,
  },
  
  -- Status line
  {
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
  },

  -- Indent lines 
  { -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      highlight = { "Function", "Label" },
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
  },

  -- Method seperator 
 -- Optimized Headlines configuration with filetype-based lazy loading
{
  "lukas-reineke/headlines.nvim",
  ft = { "markdown", "rmd", "norg", "org" }, -- Only load for these filetypes
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      -- Make sure treesitter is also optimized
      event = { "BufReadPost", "BufNewFile" },
      build = ":TSUpdate",
    }
  },
  config = function()
    -- Use vim.schedule to defer the setup
    vim.schedule(function()
      require("headlines").setup({
        markdown = {
          headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
          codeblock_highlight = "CodeBlock",
          dash_highlight = "Dash",
          dash_string = "-",
          quote_highlight = "Quote",
          quote_string = "┃",
          fat_headlines = true,
          fat_headline_upper_string = "▃",
          fat_headline_lower_string = "🬂",
        },
        rmd = {
          headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
          codeblock_highlight = "CodeBlock",
        },
        norg = {
          headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
          codeblock_highlight = "CodeBlock",
        },
        org = {
          headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
          codeblock_highlight = "CodeBlock",
        },
      })
    end)
  end,
},


  -- File tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
  
  -- Better UI components
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
  },
  
  -- Notifications
  {
    'rcarriga/nvim-notify',
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      render = 'default',
    },
  },
  
  -- Distraction-free mode
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = {
      window = {
        width = 0.85,
        options = {
          number = true,
          relativenumber = true,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = false },
        gitsigns = { enabled = false },
        tmux = { enabled = true },
      },
    },
  },

  -- Transparent background
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup {
        groups = {
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
          'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
          'LineNr', 'NonText', 'SignColumn', 'CursorLine', 'CursorLineNr',
          'StatusLine', 'StatusLineNC', 'EndOfBuffer',
        },
        extra_groups = {},
        exclude_groups = {},
      }
    end,
  },
}
