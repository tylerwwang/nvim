return {
  "NeogitOrg/neogit",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
  cmd = "Neogit",
  opts = {
	integrations = {
    	telescope = true,
		diffview = true,
	},
  }
}
