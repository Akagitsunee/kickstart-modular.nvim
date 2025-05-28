-- File: ~/.config/nvim/lua/kickstart/plugins/themes/nightfox.lua
-- Nightfox theme plugin configuration for lazy.nvim

return {
  "EdenEast/nightfox.nvim",
  name = "nightfox",
  lazy = false, -- Load immediately since it's our main theme
  priority = 1000, -- High priority to load before other plugins
  
  config = function()
    -- Setup nightfox with carbonfox customizations
    require('nightfox').setup({
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = false,     -- Disable setting background
        terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false,    -- Non focused panes set to alternative background
        module_default = true,   -- Default enable value for modules
        colorblind = {
          enable = false,        -- Enable colorblind support
          simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
          severity = {
            protan = 0,          -- Severity [0,1] for protan (red)
            deutan = 0,          -- Severity [0,1] for deutan (green)
            tritan = 0,          -- Severity [0,1] for tritan (blue)
          },
        },
        styles = {               -- Style to be applied to different syntax groups
          comments = "italic",   -- Value is any valid attr-list value `:help attr-list`
          conditionals = "NONE",
          constants = "NONE",
          functions = "NONE",
          keywords = "bold",
          numbers = "NONE",
          operators = "NONE",
          strings = "NONE",
          types = "italic,bold",
          variables = "NONE",
        },
        inverse = {             -- Inverse highlight for different types
          match_paren = false,
          visual = false,
          search = false,
        },
        modules = {             -- List of various plugins and additional options
          -- Common plugin integrations
          aerial = true,
          barbar = true,
          cmp = true,
          diagnostic = true,
          gitsigns = true,
          hop = true,
          indent_blankline = true,
          lsp_trouble = true,
          lsp_semantic_tokens = true,
          native_lsp = true,
          navic = true,
          nvimtree = true,
          symbol_outline = true,
          telescope = true,
          treesitter = true,
          tsrainbow = true,
          whichkey = true,
        },
      },
      palettes = {
        -- Custom palette for carbonfox (optional customizations)
        carbonfox = {
          -- You can override specific colors here if needed
          -- bg1 = "#161616", -- Example: darker background
          -- red = "#ee5396", -- Example: custom red
        },
      },
      specs = {
        -- Custom specifications for carbonfox (optional)
        carbonfox = {
          -- You can override syntax groups here if needed
        },
      },
      groups = {
        -- Custom highlight groups for carbonfox (optional)
        carbonfox = {
          -- Example custom highlights:
          -- NormalFloat = { fg = "fg1", bg = "bg1" },
          -- CursorLine = { bg = "bg1" },
        },
      },
    })

    -- Set carbonfox as the colorscheme
    vim.cmd("colorscheme carbonfox")

    -- Optional: Create a function to easily switch back to carbonfox
    _G.set_carbonfox = function()
      vim.cmd("colorscheme carbonfox")
    end

    -- Optional: Create a command to apply carbonfox
    vim.api.nvim_create_user_command('Carbonfox', function()
      vim.cmd('colorscheme carbonfox')
    end, {})
  end,
}