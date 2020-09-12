#!/bin/sh

VIM_DIR=$HOME/.vim
VIM_PLUGINS=$VIM_DIR/pack/vendor/start
PLUGIN_OPTS="--depth 1 --branch master"

sh clean.sh
cp .vimrc $HOME/.vimrc

# Install Plugins
mkdir -p $VIM_PLUGINS
cd $VIM_PLUGINS
git clone https://github.com/ctrlpvim/ctrlp.vim.git \
	$PLUGIN_OPTS
git clone https://github.com/preservim/nerdtree.git \
	$PLUGIN_OPTS
git clone https://github.com/vimwiki/vimwiki.git \
	$PLUGIN_OPTS
git clone https://github.com/tpope/vim-surround.git \
	$PLUGIN_OPTS
git clone https://github.com/nathanaelkane/vim-indent-guides.git \
	$PLUGIN_OPTS
git clone https://github.com/dhruvasagar/vim-table-mode.git \
	$PLUGIN_OPTS

