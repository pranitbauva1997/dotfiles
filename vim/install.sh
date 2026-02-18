#!/bin/sh

VIM_DIR=${HOME}/.vim
VIM_PLUGINS=${VIM_DIR}/pack/vendor/start
PLUGIN_OPTS="--depth 1"
DOTFILES_VIM_RC="${HOME}/Codes/dotfiles/vim/.vimrc"

link_vimrc() {
  echo "Linking .vimrc from dotfiles..."
  ln -sf "${DOTFILES_VIM_RC}" "${HOME}/.vimrc"
}

# Install Plugins (Optimized for agile viewing)
vim_plugins() {
  echo "Installing/Resetting plugins..."
  rm -rf "${VIM_PLUGINS}"
  mkdir -p "${VIM_PLUGINS}"
  cd "${VIM_PLUGINS}" || exit
  
  plugins="
    https://github.com/ctrlpvim/ctrlp.vim.git
    https://github.com/preservim/nerdtree.git
    https://github.com/tpope/vim-surround.git
    https://github.com/tpope/vim-fugitive.git
    https://github.com/vim-airline/vim-airline.git
    https://github.com/tomtom/tcomment_vim.git
    https://github.com/hdima/python-syntax.git
    https://github.com/Xuyuanp/nerdtree-git-plugin.git
    https://github.com/jeffkreeftmeijer/vim-numbertoggle.git
    https://github.com/ervandew/supertab.git
  "

  for plugin in $plugins; do
    echo "Cloning $plugin..."
    git clone ${PLUGIN_OPTS} "$plugin"
  done
}

all() {
  vim_plugins && link_vimrc
}

case "$1" in
  --all ) all ; exit; ;;
  --plugins-only ) vim_plugins ; exit; ;;
  --link-only ) link_vimrc ; exit; ;;
  * ) echo "Usage: $0 {--all|--plugins-only|--link-only}" ; exit 1; ;;
esac
