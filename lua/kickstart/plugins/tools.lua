local icons = require("kickstart.plugins.utils.icons")

-- General utilities and tools
return {
  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = { 'node_modules/', '.git/' },
          path_display = { 'truncate' },
          sorting_strategy = 'ascending',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.55,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions
      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'ui-select'

      -- Telescope Keymaps
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    end,
  },

  -- Snacks for managing UI state
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = false },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      picker = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false},
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
    },
  },

  -- Colorizer
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      enable_tailwind = false,
    }
  },

  -- File Explorer
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
      keymaps = {
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-x>'] = 'actions.select_split',
        ['<C-t>'] = 'actions.select_tab',
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = 'actions.close',
        ['<C-r>'] = 'actions.refresh',
      },
      view_options = {
        show_hidden = true,
      },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          css = { { "prettierd", "prettier" } },
          graphql = { { "prettierd", "prettier" } },
          html = { { "prettierd", "prettier" } },
          javascript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          json = { { "prettierd", "prettier" } },
          lua = { "stylua" },
          markdown = { { "prettierd", "prettier" } },
          python = { "isort", "black" },
          sql = { "sql-formatter" },
          svelte = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier", "sql-formatter" } },
          typescriptreact = { { "prettierd", "prettier" } },
          yaml = { "prettier" },
          xml = { "xmlformatter" }
        },
      })

      vim.keymap.set({ "n" }, "<leader>f", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "format file" })

      vim.keymap.set({ "v" }, "<leader>f", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "format selection" })

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end

        conform.format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })
    end,
  },

  -- Linting
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
      }

      -- Auto-lint on changes
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },

  -- Which Key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts_extend = { 'spec' },
    opts = {
        preset = "helix",
        defaults = {},
        spec = {
          {
            mode = { "n", "v" },
            -- Groups with symbols
            { "<leader>a", group = "ai/copilot", icon = { icon = "󰚩 ", color = "green" } },
            { "<leader>c", group = "code", icon = { icon = "󰅱 ", color = "yellow" } },
            { "<leader>d", group = "debug", icon = { icon = "󰃤 ", color = "red" } },
            { "<leader>e", group = "explorer", icon = { icon = "󰙅 ", color = "blue" } },
            { "<leader>f", group = "file/find", icon = { icon = "󰈞", color = "blue" } },
            { "<leader>g", group = "git", icon = { icon = " ", color = "orange" } },
            { "<leader>gh", group = "hunks", icon = { icon = "󰊢 ", color = "orange" } },
            { "<leader>q", group = "quit/session", icon = { icon = "󰗼 ", color = "red" } },
            { "<leader>s", group = "search", icon = { icon = "󰍉 ", color = "purple" } },
            { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
            { "<leader>p", group = "project", icon = { icon = "󰏗 ", color = "magenta" } },
            { "<leader>P", group = "Paste with padding", icon = { icon = "󰆒 ", color = "blue" } },
            { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },   
            -- Navigation groups with symbols
            { "[", group = "prev", icon = { icon = " ", color = "blue" } },
            { "]", group = "next", icon = { icon = " ", color = "blue" } },
            { "g", group = "goto", icon = { icon = "󰌑 ", color = "cyan" } },
            { "gs", group = "surround", icon = { icon = "󰅪 ", color = "yellow" } },
            { "z", group = "fold", icon = { icon = " ", color = "purple" } },
 
            {
              "<leader>b",
              group = "buffer",
              icon = { icon = "󰓩 ", color = "blue" },
              expand = function()
                return require("which-key.extras").expand.buf()
              end,
            },
            {
              "<leader>w",
              group = "windows",
              icon = { icon = "󱂬 ", color = "cyan" },
              proxy = "<c-w>",
              expand = function()
                return require("which-key.extras").expand.win()
              end,
            },
            -- better descriptions
            { "gx", desc = "Open with system app" },
          },
        },
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Keymaps (which-key)",
        },
        {
          "<c-w><space>",
          function()
            require("which-key").show({ keys = "<c-w>", loop = true })
          end,
          desc = "Window Hydra Mode (which-key)",
        },
      },
      config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        if not vim.tbl_isempty(opts.defaults) then
          LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
          wk.register(opts.defaults)
        end
      end,
    },

  -- Todo Comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      keywords = {
        FIX = { icon = ' ', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
    },
  },

  -- Trouble (diagnostics, references, etc.)
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      position = 'bottom',
      height = 10,
      width = 50,
      icons = true,
      mode = 'workspace_diagnostics',
      padding = true,
      auto_preview = true,
      use_diagnostic_signs = true,
    },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle<cr>', desc = 'Toggle Trouble' },
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics' },
      { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document Diagnostics' },
    },
  },

  -- Flash 
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      char = {
        keys = { "f", "F", "t", "T" },
      }
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
      { "r", mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
    },
  },

  -- UFO
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    
    config = function()
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    
      require('ufo').setup({
        open_fold_hl_timeout = 0,
        provider_selector = function(bufnr, filetype, buftype)
          -- Only apply folding to actual code files
          local code_filetypes = {
            'lua', 'python', 'javascript', 'typescript', 'javascriptreact', 
            'typescriptreact', 'go', 'rust', 'java', 'c', 'cpp', 'html', 'css'
          }
          
          -- Skip special buffers (dashboards, help, etc.)
          if buftype ~= '' then
            return ''
          end
          
          -- Skip startup screens and UI buffers
          if filetype == '' or filetype == 'dashboard' or filetype == 'alpha' or filetype == 'snacks_dashboard' then
            return ''
          end
          
          -- Only fold actual code files
          for _, ft in ipairs(code_filetypes) do
            if filetype == ft then
              return { 'treesitter', 'indent' }
            end
          end
          
          return '' -- No folding for everything else
        end,
      })
      
      -- Utility: Open all folds + restore cursor position
      local function restore_view()
        local view = vim.fn.winsaveview()
        vim.defer_fn(function()
          vim.fn.winrestview(view)
          vim.cmd("normal! zR") -- Open all folds
        end, 20)
      end
      
      -- On LSP attach: prevent folding collapse
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          restore_view()
        end,
      })
      
      -- On save: prevent folding collapse
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          restore_view()
        end,
      })
      
      -- On code action: prevent folding collapse
      vim.api.nvim_create_autocmd("User", {
        pattern = "LspCodeAction",
        callback = function()
          restore_view()
        end,
      })
    end,
  },

  -- Package Manager
  {
    "vuki656/package-info.nvim",
    event = "BufEnter package.json",
    opts = {
      colors = {
        up_to_date = "#3C4048", -- Text color for up to date package virtual text
        outdated = "#fc514e", -- Text color for outdated package virtual text
      },
      icons = {
        enable = true,                -- Whether to display icons
        style = {
          up_to_date = icons.checkSquare, -- Icon for up to date packages
          outdated = icons.gitRemove, -- Icon for outdated packages
        },
      },
      autostart = true,          -- Whether to autostart when `package.json` is opened
      hide_up_to_date = true,    -- It hides up to date versions when displaying virtual text
      hide_unstable_versions = true, -- It hides unstable versions from version list e.g next-11.1.3-canary3

      -- Can be `npm` or `yarn`. Used for `delete`, `install` etc...
      -- The plugin will try to auto-detect the package manager based on
      -- `yarn.lock` or `package-lock.json`. If none are found it will use the
      -- provided one,                              if nothing is provided it will use `yarn`
      package_manager = 'pnpm'
    }
  },
}
