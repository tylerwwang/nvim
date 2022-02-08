call plug#begin()

Plug 'tomasr/molokai'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'editorconfig/editorconfig-vim'
Plug 'universal-ctags/ctags'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-lion'
Plug 'sheerun/vim-polyglot'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/delimitMate.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'bash install.sh',
	\ }
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-repeat'
Plug 'alvan/vim-closetag'
Plug 'ryanoasis/vim-devicons'


call plug#end()

"Dependancies
"ctags
"powerline_fonts
"node

syntax on
set t_Co=256

set cursorline

let g:molokai_original = 1
colorscheme molokai

if !exists("g:airline_symbols")
	let g:airline_symbols = {}
endif

let g:airline_symbols.colnr = ''
let g:airline_section_y = ''

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1

hi Visual ctermbg=242
hi VisualNOS ctermbg=242
hi Function ctermfg=178 cterm=bold

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

map ; <Cmd>CocCommand explorer<CR>
map <CR> :Files<CR>
map _ :q<CR>
map <C-s> :mkview<CR>:w<CR>
map T :new<CR>:term<CR>
map <tab> :loadview<CR>
vmap <space> zf
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
nmap <silent> <C-l> :noh <CR>
nmap <silent> ' :TagbarToggle <CR>
nmap + <Plug>(lcn-menu)

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

let g:LanguageClient_serverCommands = {
	\ 'c': ['ccls'],
	\ 'cpp': ['ccls'],
	\ 'objc': ['ccls'],
	\ 'python': ['pyls'],
	\ }

let g:LanguageClient_useVirtualText = "CodeLens"

let g:lsp_cxx_hl_use_text_props = 1

augroup nasm_ft
	au!
	autocmd BufRead,BufNewFile *.asm set filetype=nasm
	autocmd BufNewFile,BufRead *.asm   set syntax=nasm
augroup END

