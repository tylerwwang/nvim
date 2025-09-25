return {
	{'morhetz/gruvbox'},
	{'tomasr/molokai'},
	{'editorconfig/editorconfig-vim', event="VimEnter"},
	{'morhetz/gruvbox'},
	{'tomasr/molokai'},
	{'editorconfig/editorconfig-vim'},
	{'tommcdo/vim-lion'},
	{'sheerun/vim-polyglot'},
	{'jackguo380/vim-lsp-cxx-highlight', event="VimEnter"},
	{'vim-scripts/delimitMate.vim'},
	{'ntpeters/vim-better-whitespace'},
	{'tpope/vim-repeat'},
	{'alvan/vim-closetag'},
	{'sakhnik/nvim-gdb'},
	{'Shirk/vim-gas'},
	{'preservim/tagbar'},
	{'miyakogi/conoline.vim',
		event="VimEnter",
		config=
		function()
			vim.g.conoline_auto_enable = 1
			vim.g.conoline_use_colorscheme_default_normal=1
			vim.g.conoline_use_colorscheme_default_insert=1
		end
	},
	{"lervag/vimtex",
		event="VimEnter",
		init = function()
		  vim.g.vimtex_view_method = 'skim'

		  vim.g.vimtex_syntax_enabled=0
		  vim.g.vimtex_syntax_conceal_disable = 1

		  vim.g.vimtex_view_skim_sync = 1
		  vim.g.vimtex_view_general_options = '-e'
		end},
	{"folke/todo-comments.nvim",
		tag = 'stable',
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {{}}
	}
}
