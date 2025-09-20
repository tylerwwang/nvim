return {'neoclide/coc.nvim', branch='release',
	dependencies = 'nvim-tree/nvim-web-devicons',
	config= function()
		vim.g.coc_global_extensions = {
			'coc-texlab',
			'coc-git',
			'coc-json',
			'coc-explorer',
			'coc-highlight'
		}
		vim.g.coc_filetype_map = {tex='latex'}
	end
}
