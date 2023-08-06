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
" Vim Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Vim fugitive
noremap <Leader>gd :Git diff<CR>
noremap <Leader>gl :Git log<CR>
noremap <Leader>gb :Git blame<CR>

" Terraform file configs
let g:terraform_fmt_on_save = 1
let g_terraform_align = 1

" Vim Gutter
set updatetime=250

" Vim Gutter Mappings
noremap <Leader>gn :GitGutterNextHunk<CR>
noremap <Leader>gp :GitGutterPrevHunk<CR>
nmap <Leader>gv :GitGutterPreviewHunk<CR>

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


# Install Plugins
vim_plugins() {
  rm -rf "${VIM_PLUGINS}"
  mkdir -p "${VIM_PLUGINS}"
  cd "${VIM_PLUGINS}" || exit
  eval "git clone ${PLUGIN_OPTS} https://github.com/ctrlpvim/ctrlp.vim.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/preservim/nerdtree.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/vimwiki/vimwiki.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/tpope/vim-surround.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/nathanaelkane/vim-indent-guides.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/dhruvasagar/vim-table-mode.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/tpope/vim-fugitive.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/vim-airline/vim-airline.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/hashivim/vim-terraform.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/vim-scripts/AutoClose.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/junegunn/goyo.vim.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/mg979/vim-visual-multi.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/tomtom/tcomment_vim.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/airblade/vim-gitgutter.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/hdima/python-syntax.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/Xuyuanp/nerdtree-git-plugin.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/jeffkreeftmeijer/vim-numbertoggle.git"
  eval "git clone ${PLUGIN_OPTS} https://github.com/ervandew/supertab.git"
}


vim_plugins && write_vimrc
