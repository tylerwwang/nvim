call plug#begin()

Plug 'HenryNewcomer/vim-theme-papaya'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vhdirk/vim-cmake'

call plug#end()

colorscheme papaya
let g:lightline = { 'colorscheme': 'jellybeans', }
let g:deoplete#enable_at_startup = 1

let g:NERDTreeDirArrowExpandable = ' ▸'
let g:NERDTreeDirArrowCollapsible = ' ▾'

map ; :NERDTreeToggle<CR>
map <CR> :Files<CR>
map _ :q<CR>
map <C-s> :w<CR>
map T :new<CR>:term<CR>  

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

set rnu
set number
set splitbelow

