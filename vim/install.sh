#!/bin/sh

VIM_DIR=${HOME}/.vim
VIM_PLUGINS=${VIM_DIR}/pack/vendor/start
PLUGIN_OPTS="--depth 1 --branch master"

write_vimrc() {
  cat > "${HOME}/.vimrc" <<EOF
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
let mapleader = ','

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

" Set folding
set foldmethod=indent

set backspace=indent,eol,start

" Language
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" Plugin Configurations
"
" Vim fugitive
noremap <Leader>gd :Git diff<CR>
noremap <Leader>gl :Git log<CR>
noremap <Leader>gb :Git blame<CR>

" Vim Gutter / Sync settings
set updatetime=250

" Remember folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

let python_highlight_all = 1

" NERDTree Mappings
noremap <Leader>n :NERDTreeToggle<CR>

" Tags
noremap <C-w>[ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
EOF
}


# Install Plugins (Optimized for agile viewing)
vim_plugins() {
  rm -rf "${VIM_PLUGINS}"
  mkdir -p "${VIM_PLUGINS}"
  cd "${VIM_PLUGINS}" || exit
  eval "git clone ${PLUGIN_OPTS} https://github.com/ctrlpvim/ctrlp.vim.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/preservim/nerdtree.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/tpope/vim-surround.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/tpope/vim-fugitive.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/vim-airline/vim-airline.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/tomtom/tcomment_vim.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/hdima/python-syntax.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/Xuyuanp/nerdtree-git-plugin.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/jeffkreeftmeijer/vim-numbertoggle.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/ervandew/supertab.git"
}


all() {
  vim_plugins && write_vimrc
}

case "$1" in
  --all ) all ; exit; ;;
  --vimrc-only ) write_vimrc ; exit; ;;
  * ) echo "invalid argument: $1" ; exit; ;;
esac
