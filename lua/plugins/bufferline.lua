return {
	'akinsho/bufferline.nvim',
	lazy=false,
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config= function()
		require("bufferline").setup{
			options = {
				diagnostics = "coc",
				numbers = "buffer_id",
				themable = false,
		        diagnostics_indicator = function(count, level, diagnostics_dict, context)
		            return "("..count..")"
		        end,
				diagnostics_update_in_insert = true,
		        offsets = {
		    		{
		    			filetype = "coc-explorer",
		    			text = "File Explorer",
		    			text_align = "center",
		    			separator = true
		    		}
		        },
				groups = {
					options = {
		      			toggle_hidden_on_enter = false -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
					},
					items = {
						{
							name = "CMake",
							priority = 4,
							highlight = {sp = "orange"},
							auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
							matcher = function(buf)
								return buf.name:match('CMakeLists%.txt') or buf.name:match('%.cmake')
							end,
						  	separator = { -- Optional
								style = require('bufferline.groups').separator.pill
							},
						},
						{
							name = "C",
							priority = 2,
							highlight = {sp = "purple"},
							auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
							matcher = function(buf)
								return buf.name:match('%.c') and (not buf.name:match('%.c.+')) or buf.name:match('%.h') and (not buf.name:match('%.h.+')) or  buf.name:match('%.cpp') or buf.name:match('%.hpp')
							end,
						  	separator = { -- Optional
								style = require('bufferline.groups').separator.pill
							},
						},
						{
							name = "ASM",
							priority = 3,
							highlight = {sp = "yellow"},
							auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
							matcher = function(buf)
								return (buf.name:match('%.[sS]') and (not buf.name:match('%.[sS].+')))
							end,
						  	separator = { -- Optional
								style = require('bufferline.groups').separator.pill
							},
						},
						{
							name = "Py",
							priority = 1,
							highlight = {sp = "green"},
							auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
							matcher = function(buf)
								return buf.name:match('%.py')
							end,
						  	separator = { -- Optional
								style = require('bufferline.groups').separator.pill
							},
						},
						{
							name = "Web",
							priority = 5,
							highlight = {sp = "green"},
							auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
							matcher = function(buf)
								return buf.name:match('%.html') or buf.name:match('%.css') or buf.name:match('%.scss') or buf.name:match('%.js')
							end,
						  	separator = { -- Optional
								style = require('bufferline.groups').separator.pill
							},
						},
						{
							name = "Conf",
							priority = 6,
							highlight = {sp = "purple"},
							auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
							matcher = function(buf)
								return buf.name:match('%.conf') or buf.name:match('%.yml') or buf.name:match('%.json')
							end,
						  	separator = { -- Optional
								style = require('bufferline.groups').separator.pill
							},
						},
						{
							name = "Docs",
							priority = 7,
							highlight = {sp = "red"},
							auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
							matcher = function(buf)
								return buf.name:match('%.md') or buf.name:match('%.txt') and (not buf.name:match('CMakeLists%.txt')) or buf.name:match('%.tex')
							end,
						  	separator = { -- Optional
								style = require('bufferline.groups').separator.pill
							},
						},
						{
							name = "Shell",
							priority = 8,
							highlight = {sp = "cyan"},
							auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
							matcher = function(buf)
								return buf.name:match('%.sh') and (not buf.buftype:match('terminal'))
							end,
						  	separator = { -- Optional
								style = require('bufferline.groups').separator.pill
							},
						},
						{
							name = "Out",
							priority = 9,
							highlight = {sp = "gray"},
							auto_close = true,  -- whether or not close this group if it doesn't contain the current buffer
							matcher = function(buf)
								return buf.buftype:match('terminal')
							end,
						  	separator = { -- Optional
								style = require('bufferline.groups').separator.pill
							},
						}
					}
				}
			}
		}
	end
}
