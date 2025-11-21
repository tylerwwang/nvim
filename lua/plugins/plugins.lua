return {
	{'morhetz/gruvbox'},
	{'tomasr/molokai'},
	{'editorconfig/editorconfig-vim'},
	{'morhetz/gruvbox'},
	{'tomasr/molokai'},
	{'editorconfig/editorconfig-vim'},
	{'tommcdo/vim-lion'},
	{'sheerun/vim-polyglot'},
	{'jackguo380/vim-lsp-cxx-highlight'},
	{'vim-scripts/delimitMate.vim'},
	{'ntpeters/vim-better-whitespace'},
	{'tpope/vim-repeat'},
	{'vim-scripts/closeb'},
	{'sakhnik/nvim-gdb'},
	{'Shirk/vim-gas'},
	{'preservim/tagbar'},
	{'miyakogi/conoline.vim',
		config=
		function()
			vim.g.conoline_auto_enable = 1
			vim.g.conoline_use_colorscheme_default_normal=1
			vim.g.conoline_use_colorscheme_default_insert=1
		end
	},
	{"lervag/vimtex",
		lazy=false,
		tag="v2.17",
		init = function()
		  vim.g.vimtex_view_method = 'skim'

		  vim.g.vimtex_syntax_enabled=0
		  vim.g.vimtex_syntax_conceal_disable = 1
		  vim.g.vimtex_view_skim_sync = 0

		  vim.g.vimtex_quickfix_open_on_warning = 0
		end
	},
	{"folke/todo-comments.nvim",
		tag = 'stable',
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {{}}
	},
	{"tiagovla/scope.nvim", config = true}
}
