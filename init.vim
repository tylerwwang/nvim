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

call plug#end()

syntax on
set t_Co=256

set cursorline

let g:molokai_original = 1
colorscheme molokai

let g:airline_theme='molokai'
"let g:lightline = { 'colorscheme': 'molokai' }

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

highlight Folded ctermbg=black

let s:ccls_settings = {
         \ 'highlight': { 'lsRanges' : v:true },
         \ }

let s:ccls_command = ['ccls', '-init=' . json_encode(s:ccls_settings)] 
let g:LanguageClient_serverCommands = {
      \ 'c': s:ccls_command,
      \ 'cpp': s:ccls_command,
      \ 'objc': s:ccls_command,
	  \ 'python': ['pyls']
      \ }

let g:deoplete#enable_at_startup = 1
let g:deoplete#max_list = 50

let g:deoplete#ignore_sources = {'cpp': ['buffer', 'around', 'ale']}
let g:deoplete#ignore_sources = {'python': ['buffer', 'around', 'ale']}
let g:deoplete#ignore_sources = {'c': ['buffer', 'around', 'ale']}

augroup nasm_ft
  au!
 autocmd BufRead,BufNewFile *.asm set filetype=nasm
 autocmd BufNewFile,BufRead *.asm   set syntax=nasm
augroup END
