return {
  {
    'saghen/blink.cmp',
    event = "InsertEnter", -- Only load when entering insert mode
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "fang2hou/blink-copilot",
      {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter", -- Lazy load LuaSnip too
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
          -- Defer snippet loading to avoid startup cost
          vim.schedule(function()
            require("luasnip.loaders.from_vscode").lazy_load({
              paths = { vim.fn.stdpath("config") .. "/snippets" },
            })
          end)
        end,
      },
    },

    build = 'cargo build --release',

    ---@module 'blink.cmp'
    opts = {
      keymap = {
        preset = 'super-tab',
        ["<S-k>"] = { "scroll_documentation_up", "fallback" },
        ["<S-j>"] = { "scroll_documentation_down", "fallback" }
      },

      snippets = {
        preset = 'luasnip',
        expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction) require('luasnip').jump(direction) end,
      },

      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
          'copilot',
        },

        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            opts = {
              max_completions = 3,
              max_attempts = 4,
            },
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        }
      },

      completion = {
        trigger = {
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = { "'", '"', '(', '{' },
        },
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            treesitter = {},
          },
        },

        accept = {
          auto_brackets = { enabled = false },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          treesitter_highlighting = true,
        },

        ghost_text = {
          enabled = true,
        },
      },

      signature = {
        enabled = true,
      },
    },

    opts_extend = { "sources.default" },

    appearance = {
      kind_icons = {
        Copilot = "",
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',
        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',
        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',
        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',
        Keyword = '󰻾',
        Constant = '󰏿',
        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },
  },

  -- { -- Auto pairs and surround
  --   'windwp/nvim-autopairs',
  --   event = 'InsertEnter',
  --   opts = {
  --     check_ts = true,
  --     ts_config = {
  --       lua = { 'string' },
  --       javascript = { 'template_string' },
  --       java = false,
  --     },
  --     fast_wrap = {
  --       map = '<M-e>',
  --       chars = { '{', '[', '(', '"', "'" },
  --       pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
  --       end_key = '$',
  --       keys = 'qwertyuiopzxcvbnmasdfghjkl',
  --       check_comma = true,
  --       highlight = 'Search',
  --       highlight_grey = 'Comment',
  --     },
  --   },
  -- },
}