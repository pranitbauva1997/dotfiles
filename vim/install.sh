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
git clone https://github.com/fatih/vim-go.git \
    $PLUGIN_OPTS
git clone https://github.com/tpope/vim-fugitive.git \
    $PLUGIN_OPTS
git clone https://github.com/vim-airline/vim-airline.git \
    $PLUGIN_OPTS
git clone https://github.com/hashivim/vim-terraform.git \
    $PLUGIN_OPTS
git clone https://github.com/SirVer/ultisnips.git \
    $PLUGIN_OPTS
git clone https://github.com/honza/vim-snippets.git \
    $PLUGIN_OPTS
git clone https://github.com/alvan/vim-closetag.git \
    $PLUGIN_OPTS
git clone https://github.com/vim-scripts/AutoClose.git \
    $PLUGIN_OPTS
git clone https://github.com/junegunn/goyo.vim.git \
    $PLUGIN_OPTS
git clone https://github.com/mg979/vim-visual-multi.git \
    $PLUGIN_OPTS
git clone https://github.com/pangloss/vim-javascript.git \
    $PLUGIN_OPTS
git clone https://github.com/leafgarland/typescript-vim.git \
    $PLUGIN_OPTS
git clone https://github.com/MaxMEllon/vim-jsx-pretty.git \
    $PLUGIN_OPTS
git clone https://github.com/peitalin/vim-jsx-typescript.git \
    $PLUGIN_OPTS
git clone https://github.com/tomtom/tcomment_vim.git \
    $PLUGIN_OPTS

