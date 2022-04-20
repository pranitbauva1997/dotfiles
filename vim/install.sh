#!/bin/sh

VIM_DIR=${HOME}/.vim
VIM_PLUGINS=${VIM_DIR}/pack/vendor/start
YOU_COMPLETE_ME_DIR=${VIM_PLUGINS}/YouCompleteMe
PLUGIN_OPTS="--depth 1 --branch master"

usage() {
  cat << HEREDOC

   Usage: $progname (-h | --help) | (-all) | (--vim-plugin) | (--vimrc)

   arguments:
     -h, --help           show this help message and exit
     --all                install all vim configs in full setting
     --vim-plugin         install all the vim plugins
     --vimrc              install the vimrc file in appropriate location

HEREDOC
}


vimrc() {
  rm -f ${HOME}/.vimrc
  cp vimrc ${HOME}/.vimrc
}

# Install Plugins
vim_plugins() {
  rm -rf ${VIM_PLUGINS}
  mkdir -p ${VIM_PLUGINS}
  cd ${VIM_PLUGINS}
  git clone ${PLUGIN_OPTS} https://github.com/ctrlpvim/ctrlp.vim.git
  git clone ${PLUGIN_OPTS} https://github.com/preservim/nerdtree.git
  git clone ${PLUGIN_OPTS} https://github.com/vimwiki/vimwiki.git
  git clone ${PLUGIN_OPTS} https://github.com/tpope/vim-surround.git
  git clone ${PLUGIN_OPTS} https://github.com/nathanaelkane/vim-indent-guides.git
  git clone ${PLUGIN_OPTS} https://github.com/dhruvasagar/vim-table-mode.git
  git clone ${PLUGIN_OPTS} https://github.com/fatih/vim-go.git
  git clone ${PLUGIN_OPTS} https://github.com/tpope/vim-fugitive.git
  git clone ${PLUGIN_OPTS} https://github.com/vim-airline/vim-airline.git
  git clone ${PLUGIN_OPTS} https://github.com/hashivim/vim-terraform.git
  git clone ${PLUGIN_OPTS} https://github.com/ycm-core/YouCompleteMe
  git clone ${PLUGIN_OPTS} https://github.com/SirVer/ultisnips.git
  git clone ${PLUGIN_OPTS} https://github.com/honza/vim-snippets.git
  git clone ${PLUGIN_OPTS} https://github.com/alvan/vim-closetag.git
  git clone ${PLUGIN_OPTS} https://github.com/vim-scripts/AutoClose.git
  git clone ${PLUGIN_OPTS} https://github.com/junegunn/goyo.vim.git
  git clone ${PLUGIN_OPTS} https://github.com/mg979/vim-visual-multi.git
  git clone ${PLUGIN_OPTS} https://github.com/pangloss/vim-javascript.git
  git clone ${PLUGIN_OPTS} https://github.com/leafgarland/typescript-vim.git
  git clone ${PLUGIN_OPTS} https://github.com/MaxMEllon/vim-jsx-pretty.git
  git clone ${PLUGIN_OPTS} https://github.com/peitalin/vim-jsx-typescript.git
  git clone ${PLUGIN_OPTS} https://github.com/tomtom/tcomment_vim.git
  git clone ${PLUGIN_OPTS} https://github.com/airblade/vim-gitgutter.git
  git clone ${PLUGIN_OPTS} https://github.com/hdima/python-syntax.git
  git clone ${PLUGIN_OPTS} https://github.com/Xuyuanp/nerdtree-git-plugin.git
  git clone ${PLUGIN_OPTS} https://github.com/jeffkreeftmeijer/vim-numbertoggle.git
  git clone ${PLUGIN_OPTS} https://github.com/ervandew/supertab.git
  setup_you_complete_me
}

setup_you_complete_me() {
  cd ${YOU_COMPLETE_ME_DIR}
  git submodule update --init --recursive
  python3 install.py -all
}

all() {
  vim_plugins && vimrc
}

case "$1" in
  -h | --help ) usage ; exit; ;;
  --all ) all ; exit; ;;
  --vimrc ) vimrc ; exit; ;;
  --vim-plugin ) vim_plugin ; exit; ;;
  * ) echo "invalid argument: $1" && usage ; exit; ;;
esac

