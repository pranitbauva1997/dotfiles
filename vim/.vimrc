filetype on
filetype plugin indent on
set encoding=utf-8
set fileencoding=utf-8
set number
set relativenumber
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
syntax enable
set lazyredraw
set showmatch
set spell
set hlsearch
colorscheme pablo
let mapleader = " "

" Clipboard and Keymaps
set clipboard=unnamedplus
vnoremap <C-c> "+y

" Set custom indent width for particular filetype
autocmd Filetype html set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype css set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype javascript set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype javascriptreact set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype typescript set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype typescriptcommon set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype typescriptreact set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype json set shiftwidth=2 softtabstop=2 tabstop=2

autocmd Filetype make set noexpandtab

" Set spell check for markdown and text file
autocmd Filetype markdown set spell
autocmd Filetype markdown_tablemode set spell
autocmd Filetype text set spell

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" Set autoread to refresh files changed outside vim
set autoread
augroup autorefresh
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
augroup END

" Set folding
set foldmethod=indent

let python_highlight_all = 1

" NERDTree Mappings
noremap <Leader>n :NERDTreeToggle<CR>

" Tags
noremap <C-w>[ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
