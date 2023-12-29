call plug#begin()
Plug 'tomasr/molokai'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'editorconfig/editorconfig-vim'
Plug 'universal-ctags/ctags'
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
Plug 'ryanoasis/vim-devicons'
Plug 'cohama/agit.vim'
Plug 'jreybert/vimagit'
Plug 'sakhnik/nvim-gdb'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'Shirk/vim-gas'
Plug 'xuhdev/vim-latex-live-preview', {'for': 'tex'}
call plug#end()

"Dependancies
"ctags
"node
"solargraph
"pynvim
let g:nvimgdb_use_find_executables = 0
let g:nvimgdb_use_cmake_to_find_executables = 0

syntax on
set t_Co=256

set wrap
set nolist
set cursorline
set linebreak

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
let g:airline#extensions#tabline#enabled =	 1
let g:airline#extensions#whitespace#enabled = 0

function! s:update_git_status()
  let g:airline_section_b = "%{get(g:,'coc_git_status','')}"
endfunction

let g:airline_section_b = "%{get(g:,'coc_git_status','')}"

autocmd User CocGitStatusChange call s:update_git_status()

autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'

hi Visual ctermbg=242
hi VisualNOS ctermbg=242
hi Function ctermfg=178 cterm=bold
hi Search ctermfg=129 ctermbg=226 cterm=bold

hi PreProc ctermfg=97
hi Macro ctermfg=130 cterm=bold
hi PreCondit guifg=#875faf ctermfg=97 cterm=none

hi Directory ctermfg=183
hi CursorLineNr ctermfg=220 ctermbg=232
hi LineNr ctermfg=240 ctermbg=233
hi Number ctermfg=138

hi MatchParen cterm=underline ctermfg=220 ctermbg=none
hi Normal ctermbg=233

hi ExtraWhitespace ctermbg=236

let g:NERDTreeDirArrowExpandable = ' ▸'
let g:NERDTreeDirArrowCollapsible = ' ▾'

nmap <silent> <S-tab> <Cmd>CocCommand explorer<CR>
map <silent><CR> :Files<CR>
map <C-s> :w<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nmap <silent> <C-l> :noh <CR>
nmap <silent> ' :TagbarToggle <CR>
nmap - zc
nmap = zo
nmap + zR
nmap _ zM
nmap <leader>D :StripWhitespace <CR>

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

nnoremap <M-w> <C-w>
nmap <silent><leader>s :split <CR>
nmap <silent><leader>v :vsplit <CR>

command! CBuild !./compile.sh
command! -nargs=* CConfig !./configure.sh <f-args>
command! CClean !./clean.sh
command! -nargs=* CRun call CRun(<f-args>)
command! Td bp<bar>sp<bar>bn<bar>bd
command! InitCScript !~/.config/nvim/c_script.sh

function! CRun(file)
	execute "vsplit"
	execute "term ./run.sh " .a:file
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
	autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=en_us
	autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_us
augroup END

noremap j gj
noremap k gk

"augroup updown_ft
"	au!
"	autocmd BufRead,BufNewFile *.tex noremap <buffer> k gk
"	autocmd BufRead,BufNewFile *.tex noremap <buffer> j gj
"augroup END

let g:coc_global_extensions = ['coc-git', 'coc-json', 'coc-python', 'coc-explorer', 'coc-tsserver', 'coc-highlight', 'coc-solargraph']

filetype plugin on
let g:instant_markdown_autostart = 0

