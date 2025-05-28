-- Optimized Treesitter configuration for better startup performance
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" }, -- Lazy load on file operations
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy", -- This was taking 21.79ms - defer it
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy", -- Load after treesitter
        opts = {
          max_lines = 3, -- Limit context lines for performance
        },
      },
    },
    config = function()
      -- Use vim.schedule to defer heavy treesitter setup
      vim.schedule(function()
        require("nvim-treesitter.configs").setup({
          -- Only install parsers you actually use
          ensure_installed = {
            "lua",
            "javascript",
            "typescript",
            "tsx",
            "json",
            "html",
            "css",
            "markdown",
            "markdown_inline",
            "vim",
            "vimdoc",
            -- Add only languages you actually use
          },
          
          -- Don't install all parsers synchronously
          sync_install = false,
          
          -- Install parsers asynchronously 
          auto_install = true,
          
          highlight = {
            enable = true,
            -- Disable for large files to maintain performance
            disable = function(lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,
            
            -- Improve performance by reducing additional highlighting
            additional_vim_regex_highlighting = false,
          },
          
          -- Defer textobjects setup
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
              },
            },
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
              },
              goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
              },
              goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
              },
              goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
              },
            },
          },
          
          -- Optimize incremental selection
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "<C-space>",
              node_incremental = "<C-space>",
              scope_incremental = false,
              node_decremental = "<bs>",
            },
          },
          
          -- Optimize indentation
          indent = {
            enable = true,
            -- Disable for problematic languages
            disable = { "python", "yaml" },
          },
        })
      end)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
