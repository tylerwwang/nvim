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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-repeat'
Plug 'alvan/vim-closetag'
Plug 'ryanoasis/vim-devicons'
Plug 'cohama/agit.vim'
Plug 'jreybert/vimagit'

call plug#end()

"Dependancies
"ctags
"node
"solargraph

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
   let g:airline_powerline_fonts =   1
let g:airline#extensions#tabline#enabled =	 1
let g:airline#extensions#whitespace#enabled = 0

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
map <C-s> :w<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nmap <silent> <C-l> :noh <CR>
nmap <silent> ' :TagbarToggle <CR>
nmap - zc
nmap = zo
nmap + zR
nmap _ zM
nmap <leader>d :StripWhitespace <CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
	autocmd BufRead,BufNewFile *.x64.s set filetype=asm
	autocmd BufNewFile,BufRead *.x64.s set syntax=asm
	autocmd BufRead,BufNewFile *.x64.S set filetype=asm
	autocmd BufNewFile,BufRead *.x64.S set syntax=asm
augroup END
augroup asm_aa64_ft
	au!
	autocmd BufRead,BufNewFile *.aa64.S set filetype=arm64asm
	autocmd BufNewFile,BufRead *.aa64.S set syntax=arm64asm
	autocmd BufRead,BufNewFile *.aa64.S set filetype=arm64asm
	autocmd BufNewFile,BufRead *.aa64.S set syntax=arm64asm
augroup END

let g:coc_global_extensions = ['coc-git', 'coc-json', 'coc-python', 'coc-explorer', 'coc-tsserver', 'coc-highlight', 'coc-solargraph']
