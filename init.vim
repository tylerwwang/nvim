call plug#begin()

"Plug 'sonph/onehalf', { 'rtp': 'vim' }
"Plug 'itchyny/lightline.vim'
Plug 'tomasr/molokai'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'vhdirk/vim-cmake'
Plug 'petrbroz/vim-glsl'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'bash install.sh',
	\ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/delimitMate.vim'
Plug 'majutsushi/tagbar'
Plug 'jreybert/vimagit'
Plug 'vim-scripts/vim-gitgutter'
Plug 'mox-mox/vim-localsearch'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'

call plug#end()

"Dependancies
"ctags
"powerline_fonts
"python3

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

hi Visual ctermbg=237
hi VisualNOS ctermbg=237
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

let g:NERDTreeDirArrowExpandable = ' ▸'
let g:NERDTreeDirArrowCollapsible = ' ▾'

map ; :NERDTreeToggle<CR>
map <CR> :Files<CR>
map _ :q<CR>
map <C-s> :mkview<CR>:w<CR>
map T :new<CR>:term<CR>
map <tab> :loadview<CR>
vmap <space> zf
nmap + <Plug>(lcn-menu)
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
nmap <silent> <C-l> :noh <CR>
nmap <silent> ' :TagbarToggle <CR>

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

call ale#Set('nasm_nasm_options', '-felf64')

let s:ccls_settings = {
	\ 'highlight': { 'lsRanges' : v:true },
	\ }

let s:ccls_command = ['ccls', '-init=' . json_encode(s:ccls_settings)]
let g:LanguageClient_serverCommands = {
	\ 'c': s:ccls_command,
	\ 'cpp': s:ccls_command,
	\ 'objc': s:ccls_command,
	\ 'python': ['pyls'],
	\ }

let g:deoplete#enable_at_startup = 1
"let g:deoplete#max_list = 50
"let g:deoplete#ignore_sources = {'cpp': ['buffer', 'around', 'ale']}
"let g:deoplete#ignore_sources = {'python': ['buffer', 'around', 'ale']}
"let g:deoplete#ignore_sources = {'c': ['buffer', 'around', 'ale']}

call deoplete#custom#option({
	\'max_list': 25,
	\'sources': {
		\'cpp': ['LanguageClient'],
		\'python': ['LanguageClient'],
		\'c': ['LanguageClient'],
		\},
	\'auto_complete_delay': 100
	\})


augroup nasm_ft
	au!
	autocmd BufRead,BufNewFile *.asm set filetype=nasm
	autocmd BufNewFile,BufRead *.asm   set syntax=nasm
augroup END

nmap <leader>/ <Plug>localsearch_toggle
