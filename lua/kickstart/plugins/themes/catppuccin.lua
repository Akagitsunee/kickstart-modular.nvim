return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "macchiato", -- other options: "mocha", "frappe", "latte"
    integrations = {
	cmp = true,
	gitsigns = true,
	nvimtree = true,
	treesitter = true,
	telescope = true,
	-- anything else you use
      },
      no_italic = true, -- italics can be overwhelming
      no_bold = false,
    },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    -- vim.cmd.colorscheme("catppuccin")
  end,
}

