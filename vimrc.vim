"Dependancies
"ctags
"node
"ccls

set termguicolors
set t_Co=256

syntax on
filetype plugin on

set wrap
set nolist
set cursorline
set linebreak
set mousemoveevent
set foldmethod=indent

set updatetime=50

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

set background=light

"Key Maps
nmap <silent> <S-tab> <Cmd>CocCommand explorer<CR>
nmap <silent> <leader>M <cmd>Neogit<CR>

nmap <esc> <Nop>

nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

nmap <silent> <tab> <Plug>(coc-codeaction-cursor)
nmap <silent> F <Plug>(coc-fix-current)

nmap <silent><CR> <cmd>Telescope find_files<CR>
nmap <silent><S-CR> <cmd>Telescope buffers<CR>
map <silent><F1> <cmd>Telescope neoclip<CR>
map <silent><F2> <cmd>Telescope macroscope<CR>
map <silent><F3> <cmd>Telescope commands<CR>
map <silent><F4> <cmd>Telescope coc<CR>
map <silent><F12> <cmd>lua require('telescope.builtin').keymaps()<CR>

map <silent><F11> :SwapColor <CR>

nmap <silent> <C-l> :noh <CR>
nmap <silent> ' :TagbarToggle <CR>

nmap - zc
nmap = zo
nmap + zR
nmap _ zM

nmap <leader>D :StripWhitespace <CR>

vmap D "_d
nmap DD "_dd
vmap DD "_dd

nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)

nmap <leader>dc :Gdb<Space>
nmap <leader>dL :GdbStartLlldb out/debug/
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

noremap j gj
noremap k gk

nmap <silent> <leader>l :Agit<CR>

nmap <silent> \ :TexGoto<CR>

"Custom Commands
command! CBuild call CBuild()
command! -nargs=* CConfig !./configure.sh <f-args>
command! CClean !./make.sh clean
command! CReset !./reset.sh
command! CReTest call CTest("r")
command! CTest call CTest("")
command! T call Term()
command! -nargs=* CRun call CRun(<f-args>)
command! CloseTerm :BufferLineGroupClose Out

command! Td bp<bar>sp<bar>bn<bar>bd
command! Tdo bp<bar>sp<bar>bn<bar>bd!
command! Tq bp<bar>sp<bar>bn<bar>bd<bar>q
command! Tqo bp<bar>sp<bar>bn<bar>bd!<bar>q!

command!Tc :tabclose

command! InitCScript !~/config/nvim/c_script.sh

command! SwapColor call SwapColor()

let g:gruvbox_contrast_light = "hard"
let g:gruvbox_light = 1
let g:gruvbox_italic = 1

let g:molokai_original = 1
"let g:airline_theme='murmur'

function! SetColor()
	if &background == 'light'
		hi! CocWarningLine ctermbg=229 guibg=#ffffaf
		hi! CocErrorLine ctermbg=216 guibg=#ffaf87

		hi! CocWarningSign guifg=#ffaf00
		hi! CocWarningHighlight gui=undercurl guisp=#ffaf00

		hi MatchParen cterm=underline ctermfg=220 ctermbg=none gui=underline,bold guibg=none guifg=#5ec718

		hi! ExtraWhitespace ctermbg=223 guibg=#ffd7af
	else
		hi! Visual ctermbg=242 guibg=#6c6c6c
		hi! VisualNOS ctermbg=242 guibg=#6c6c6c
		hi! Function ctermfg=178 cterm=bold gui=bold guifg=#FFDD00
		hi! Search ctermfg=129 ctermbg=226 cterm=bold gui=bold guifg=#af00ff guibg=#ffff00

		hi! PreProc ctermfg=97 guifg=#875faf
		hi! Macro ctermfg=130 cterm=bold gui=bold guifg=#af5f00
		hi! PreCondit guifg=#875faf ctermfg=97 cterm=none gui=none

		hi! Directory ctermfg=183 guifg=#d7afff
		hi! String guifg=#E0D879
		hi! CursorLineNr ctermfg=220 ctermbg=232 guifg=#ffd700 guibg=#080808
		hi! CursorLine guibg=#383838
		hi! LineNr ctermfg=240 ctermbg=233 guifg=#585858 guibg=#121212
		hi! Number ctermfg=138 guifg=#af8787

		hi! Normal ctermbg=233 guibg=#121212

		hi! ExtraWhitespace ctermbg=236 guibg=#303030

		hi! CocWarningLine ctermbg=136 guibg=#4f2700
		hi! CocErrorLine ctermbg=52 guibg=#2f0f00

		hi! DiagnosticUnderlineError gui=undercurl
		hi! DiagnosticUnderlineWarn gui=undercurl
		hi! DiagnosticUnderlineInfo gui=undercurl
		hi! DiagnosticUnderlineHint gui=undercurl

		hi MatchParen cterm=underline ctermfg=220 ctermbg=none gui=underline,bold guibg=none guifg=#5ec718

		hi! Curl cterm=undercurl gui=undercurl
	endif
endfunction

function! SetScheme()
	if &background == 'light'
		colorscheme gruvbox
		call SetColor()
	else
		colorscheme molokai
		call SetColor()
	endif
endfunction

function! SwapColor()
	if &background == 'light'
		set background=dark
		call SetScheme()
	else
		set background=light
		call SetScheme()
	endif
endfunction

call SetScheme()


"Delimate Settings
au FileType html let b:delimitMate_autoclose = 0

"Better Whitespace
let g:strip_whitespace_on_save = 1
let g:strip_max_file_size = 2000

"Airline Settings
if !exists("g:airline_symbols")
	let g:airline_symbols = {}
endif

let g:airline_symbols.colnr = ''
let g:airline_section_y = ''
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#nvimlsp#enabled = 1
let g:airline_powerline_fonts =   1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_filetype_overrides = {
	\ 'coc-explorer':  [ 'CoC Explorer', '' ],
	\ 'defx':  ['defx', '%{b:defx.paths[0]}'],
	\ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
	\ 'floggraph':  [ 'Flog', '%{get(b:, "flog_status_summary", "")}' ],
	\ 'gundo': [ 'Gundo', '' ],
	\ 'help':  [ 'Help', '%f' ],
	\ 'minibufexpl': [ 'MiniBufExplorer', '' ],
	\ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
	\ 'startify': [ 'startify', '' ],
	\ 'vim-plug': [ 'Plugins', '' ],
	\ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
	\ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
	\ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
\ }

function! s:update_git_status()
  let g:airline_section_b = "%{get(g:,'coc_git_status','')}"
endfunction

let g:airline_section_b = "%{get(g:,'coc_git_status','')}"

autocmd User CocGitStatusChange call s:update_git_status()

"LATEX Settings
augroup TexAutomation
    autocmd!
  	autocmd VimLeave * call TexCleanAll()
  	autocmd BufUnload,BufDelete,BufWipeout *.tex call TexCleanBuffer(bufnr())
augroup END

function! TexCleanAll()
	for buf in getbufinfo({'bufloaded': 1})
		if fnamemodify(buf.name, ':e') ==# 'tex'
    		silent! buffer buf.bufnr
			silent! TexClean
    	endif
	endfor
endfunction

function! TexCleanBuffer(closing_bufnr)
	" Get root of the buffer being closed
	let closing_vimtex = getbufvar(a:closing_bufnr, 'vimtex', v:null)
	if closing_vimtex is# v:null || empty(closing_vimtex)
	  return
	endif

	let closing_root = closing_vimtex.tex

	if empty(closing_root)
		return
	endif

	" Look through all other loaded buffers
	for buf in getbufinfo({'bufloaded': 1})
	  if buf.bufnr != a:closing_bufnr
		let other_vimtex = getbufvar(buf.bufnr, 'vimtex', v:null)
		if other_vimtex is# v:null || empty(other_vimtex)
			continue
		endif
	    let other_root = other_vimtex.tex
	    if other_root isnot# v:null && other_root ==# closing_root
	      " Found another buffer with the same root → skip cleaning
	      return
	    endif
	  endif
	endfor

	" No other buffer shares the same root → run TexClean
	execute 'TexClean'
endfunction


"Markdown Live Preview
let g:instant_markdown_autostart = 0

"LLDB Configuration
let g:nvimgdb_use_find_executables = 0
let g:nvimgdb_use_cmake_to_find_executables = 0

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

function! Term()
	call CheckTerm()
	execute "term"
endfunction

function! CheckTerm()
	if getwininfo(win_getid(winnr('$')))[0].terminal
		call win_gotoid(win_getid(winnr('$')))
	else
		execute "botright split"
		execute "resize 25"
	endif
endfunction

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

"ASM/C/C++ Syntax
let g:c_syntax_for_h = 1
let g:lsp_cxx_hl_use_text_props = 1

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

au CursorHold * sil call CocActionAsync('highlight')
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
