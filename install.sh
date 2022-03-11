#!/bin/sh

PROJ_DIR=${PWD}
VIM_DIR=${PWD}/vim
GIT_DIR=${PWD}/git
progname="$0"

vimrc() {
  cd ${VIM_DIR}
  sh install.sh --vimrc
  cd ${PROJ_DIR}
}

vim_plugin() {
  cd ${VIM_DIR}
  sh install.sh --vim-plugin
  cd ${PROJ_DIR}
}

vim() {
  cd ${VIM_DIR}
  sh install.sh --all
  cd ${PROJ_DIR}
}

git() {
  cd ${GIT_DIR}
  sh install.sh
  cd ${PROJ_DIR}
}

bin() {
  echo "install the custom scripts"
}

docker() {
  echo "install the docker config"
}

starship() {
  echo "install starship config"
}

all() {
  echo "install all configs"
  vim && git && bin
}

usage()
{
  cat << HEREDOC

   Usage: $progname (-h | --help) | (-all) | (--bin) | (--git) | (--vim-plugin) | (--vimrc)

   arguments:
     -h, --help           show this help message and exit
     --all                install all the configs in full setting
     --bin                install all the custom scripts
     --git                install all the git configs and aliases
     --vim-plugin         install all the vim plugins
     --vimrc              install the vimrc file in appropriate location
     --docker             install the docker config
     --starship           install the starship config

HEREDOC
}  

case "$1" in
  -h | --help ) usage; exit; ;;
  --all ) all ; exit; ;;
  --bin ) bin ; exit; ;;
  --git ) git ; exit;  ;;
  --vim-plugin ) vim_plugin ; exit; ;;
  --vimrc ) vimrc ; exit; ;;
  --docker ) docker ; exit; ;;
  --starship ) starship ; exit; ;;
  * ) echo "invalid argument: $1" && usage ; exit; ;;
esac
