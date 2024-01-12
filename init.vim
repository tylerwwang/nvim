call plug#begin()
Plug 'tomasr/molokai'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-lion'
Plug 'sheerun/vim-polyglot'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/delimitMate.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-repeat'
Plug 'alvan/vim-closetag'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'cohama/agit.vim'
Plug 'jreybert/vimagit'
Plug 'sakhnik/nvim-gdb'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'Shirk/vim-gas'
Plug 'xuhdev/vim-latex-live-preview', {'for': 'tex'}
Plug 'lervag/vimtex'
Plug 'preservim/tagbar'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'miyakogi/conoline.vim'
Plug 'gucciwang123/vim-airline-themes'
call plug#end()

"Dependancies
"ctags
"node
"pynvim
let g:nvimgdb_use_find_executables = 0
let g:nvimgdb_use_cmake_to_find_executables = 0

set termguicolors

syntax on
set t_Co=256

set wrap
set nolist
set cursorline
set linebreak
set mousemoveevent

let g:molokai_original = 1
colorscheme molokai

if !exists("g:airline_symbols")
	let g:airline_symbols = {}
endif

let g:airline_symbols.colnr = ''
let g:airline_section_y = ''
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline_powerline_fonts =   1
let g:airline#extensions#whitespace#enabled = 0

let g:conoline_auto_enable = 1

function! s:update_git_status()
  let g:airline_section_b = "%{get(g:,'coc_git_status','')}"
endfunction

let g:airline_section_b = "%{get(g:,'coc_git_status','')}"

autocmd User CocGitStatusChange call s:update_git_status()

autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'

hi Visual ctermbg=242 guibg=#6c6c6c
hi VisualNOS ctermbg=242 guibg=#6c6c6c
hi Function ctermfg=178 cterm=bold gui=bold guifg=#FFDD00
hi Search ctermfg=129 ctermbg=226 cterm=bold gui=bold guifg=#af00ff guibg=#ffff00

hi PreProc ctermfg=97 guifg=#875faf
hi Macro ctermfg=130 cterm=bold gui=bold guifg=#af5f00
hi PreCondit guifg=#875faf ctermfg=97 cterm=none gui=none

hi Directory ctermfg=183 guifg=#d7afff
hi String guifg=#E0D879
hi CursorLineNr ctermfg=220 ctermbg=232 guifg=#ffd700 guibg=#080808
hi CursorLine guibg=#383838
hi LineNr ctermfg=240 ctermbg=233 guifg=#585858 guibg=#121212
hi Number ctermfg=138 guifg=#af8787

hi MatchParen cterm=underline ctermfg=220 ctermbg=none gui=underline,bold guibg=none guifg=#5ec718
hi Normal ctermbg=233 guibg=#121212

hi ExtraWhitespace ctermbg=236 guibg=#303030

let g:airline_theme='murmur'

nmap <silent> <S-tab> <Cmd>CocCommand explorer<CR>
map <silent><CR> :Files<CR>

nnoremap <C-s> :w<CR>
inoremap <C-s> :w<CR>
vnoremap <C-s> :w<CR>

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
nmap <silent> <C-l> :noh <CR>
nmap <silent> ' :TagbarToggle <CR>
nmap - zc
nmap = zo
nmap + zR
nmap _ zM
nmap <leader>D :StripWhitespace <CR>

vnoremap <leader>p "_dP

vnoremap f "_d
vnoremap ff "_dd
nnoremap ff "_dd

nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)

nmap <leader>dc :Gdb<Space>
nmap <leader>dL :GdbStartLLDB lldb out/debug/
nmap <silent><leader>dw :call Watch()<CR>
nmap <silent><leader>dt :GdbLopenBacktrace <CR>
nmap <silent><leader>dq :GdbDebugStop <CR>

nmap <silent><leader>wr :GdbCreateWatch register read<CR>
nnoremap <silent><leader>wm :<C-u>exe 'call MemWatch(' . v:count1 . ')'<CR>
nnoremap <silent><leader>wM :<C-u>exe 'call MemWatchR(' . v:count1 . ')'<CR>
nmap <silent><leader>wu :doautocmd User NvimGdbQuery<CR>
nmap <silent><leader>wv :GdbCreateWatch fr v<CR>
nmap <silent><leader>wa :GdbCreateWatch disassemble --frame<CR>

nmap <leader>mp :InstantMarkdownPreview<CR>
nmap <leader>ms :InstantMarkdownStop<CR>

nmap <silent><leader>s :split <CR>
nmap <silent><leader>v :vsplit <CR>
nmap , @@

nmap <silent><leader>- :Td <CR>
nmap <silent><leader>q :Tq <CR>

command! CBuild call CBuild()
command! -nargs=* CConfig !./configure.sh <f-args>
command! CClean !./make.sh clean-all
command! CReset !./reset.sh
command! CReTest call CTest("r")
command! CTest call CTest("")
command! GitPush !git push origin
command! GitPull !git pull
command! -nargs=* CRun call CRun(<f-args>)
command! Td bp<bar>sp<bar>bn<bar>bd
command! Tdo bp<bar>sp<bar>bn<bar>bd!
command! Tq bp<bar>sp<bar>bn<bar>bd<bar>q
command! Tqo bp<bar>sp<bar>bn<bar>bd!<bar>q!
command! InitCScript !~/.config/nvim/c_script.sh

function! CRun(file)
	call CheckTerm()
	execute "term ./run.sh " .a:file
endfunction

function! CTest(rerun)
	call CheckTerm()
	execute "term ./test.sh " .a:rerun
endfunction

function! CBuild()
	call CheckTerm()
	execute "term ./make.sh "
endfunction

function! CheckTerm()
	if getwininfo(win_getid(winnr('$')))[0].terminal
		call win_gotoid(win_getid(winnr('$')))
	else
		execute "botright split"
		execute "resize 25"
	endif
endfunction

nmap <silent> <leader>l :Agit<CR>

function! MemWatch(count)
	let l:count = a:count * 8
	if a:count == 1
		let l:count = 400
	endif

	let l:address = input("Initial Address: ")

	execute "GdbCreateWatch x -s2 -fx -c" . l:count . " " . ((address/0x10)*0x10)
endfunction
function! MemWatchR(count)
	let l:count = (a:count) * 8
	if a:count == 1
		let l:count = 400
	endif

	let l:address = ((input("Top Address: ") - l:count*2) + 2)

	execute "GdbCreateWatch x -s2 -fx -c" . l:count . " " . ((address/0x10)*0x10 + 0x10)
endfunction
function! Watch()
	let l:cmd = input("Command: ")

	execute "GdbCreateWatch " . l:cmd
endfunction

set foldmethod=indent

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

set rnu
set number
set splitbelow

set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

let g:lsp_cxx_hl_use_text_props = 1

"augroup nasm_ft
"	au!
"	autocmd BufRead,BufNewFile *.asm set filetype=nasm
"	autocmd BufNewFile,BufRead *.asm   set syntax=nasm
"augroup END

augroup asm_x64_ft
	au!
	autocmd BufRead,BufNewFile *.x64.s set filetype=gas
	autocmd BufNewFile,BufRead *.x64.s set syntax=gas
	autocmd BufRead,BufNewFile *.x64.S set filetype=gas
	autocmd BufNewFile,BufRead *.x64.S set syntax=gas
augroup END
augroup asm_aa64_ft
	au!
	autocmd BufRead,BufNewFile *.aa64.s set filetype=aarch64
	autocmd BufNewFile,BufRead *.aa64.s set syntax=aarch64
	autocmd BufRead,BufNewFile *.aa64.S set filetype=aarch64
	autocmd BufNewFile,BufRead *.aa64.S set syntax=aarch64
augroup END

function! LldbAcmd()
	let l:id = bufnr("disassemble --frame")
	if l:id != -1
		call win_execute(win_findbuf(l:id)[0], "au! TextChanged <buffer> execute \"%s/.\\\\[\\\\d\\\\+m/\\t/ge\"", 1)
		call win_execute(win_findbuf(l:id)[0], "%s/.\\[\\d\\+m/\t/ge", 1)
	endif
endfunction

augroup lldb_st
	au!
	autocmd User NvimGdbQuery call LldbAcmd()
	autocmd BufEnter,BufNewFile disassemble?--frame set syntax=LLDB_ASM
	autocmd BufEnter,BufNewFile disassemble?--frame set filetype=LLDB_ASM

	autocmd BufEnter,BufNewFile  x?-s2?-fx?-c* set syntax=LLDB_MEM
	autocmd BufEnter,BufNewFile x?-s2?-fx?-c* set filetype=LLDB_MEM

	autocmd BufEnter,BufNewFile  fr?v set syntax=LLDB_VAR
	autocmd BufEnter,BufNewFile fr?v set filetype=LLDB_VAR

	autocmd BufEnter,BufNewFile  register?read set syntax=LLDB_REG
	autocmd BufEnter,BufNewFile register?read set filetype=LLDB_REG
augroup END

augroup spell_ft
	au!
	autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
	autocmd BufRead,BufNewFile *.html setlocal spell spelllang=en_us
	autocmd FileType text setlocal spell
	autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_us
augroup END

noremap j gj
noremap k gk

let g:coc_global_extensions = ['coc-git', 'coc-json', 'coc-python', 'coc-explorer', 'coc-tsserver', 'coc-highlight']

filetype plugin on
let g:instant_markdown_autostart = 0

lua << EOF
local bufferline = require("bufferline")
bufferline.setup({
	options = {
		diagnostics = "coc",
		numbers = "buffer_id",
		themable = false,
        hover = {
            enabled = true,
            delay = 10,
            reveal = {'close'}
        },
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
        end,
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
					priority = 3,
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
					priority = 1,
					highlight = {sp = "purple"},
					auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
					matcher = function(buf)
						return buf.name:match('%.c') or buf.name:match('%.h') or  buf.name:match('%.cpp') or buf.name:match('%.hpp')
					end,
				  	separator = { -- Optional
						style = require('bufferline.groups').separator.pill
					},
				},
				{
					name = "Py",
					priority = 2,
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
					name = "Docs",
					priority = 4,
					highlight = {sp = "cyan"},
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
					priority = 5,
					highlight = {sp = "yellow"},
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
					priority = 6,
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
})
EOF
