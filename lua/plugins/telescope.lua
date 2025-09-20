return {
	{'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim'},
		config =
		function ()
			local actions = require("telescope.actions")
			require("telescope").setup({
					defaults = {
						file_ignore_patterns = { "node%_modules/.*" },
						mappings = {
							n = {
								["<C-c>"] = actions.close
							},
							i = {
								["<C-d>"] = actions.delete_buffer + actions.move_to_top,
							}
						}
					},
					extensions = {
						coc = {
							theme = 'ivy',
							prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
							push_cursor_on_edit = true, -- save the cursor position to jump back in the future
							timeout = 3000, -- timeout for coc commands
						}
					},
				})
			require('telescope').load_extension('coc')
		end
	},
	{'fannheyward/telescope-coc.nvim'},
}
