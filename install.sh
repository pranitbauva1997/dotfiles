#!/bin/bash

PROJ_DIR=${PWD}
VIM_DIR=${PWD}/vim
GIT_DIR=${PWD}/git
progname="$0"

function vimrc() {
  echo "install the vimrc config"
}

function vim_plugin() {
  echo "install the vim plugins"
}

function vim() {
  cd ${VIM_DIR}
  sh install.sh
  cd ${PROJ_DIR}
}

function git() {
  cd ${GIT_DIR}
  sh install.sh
  cd ${PROJ_DIR}
}

function bin() {
  echo "install the custom scripts"
}

function all() {
  echo "install all configs"
  vim && git && bin
}

function usage()
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

HEREDOC
}  

case "$1" in
  -h | --help ) usage; exit; ;;
  --all ) all ; exit; ;;
  --bin ) bin ; exit; ;;
  --git ) git ; exit;  ;;
  --vim-plugin ) vim_plugin ; exit; ;;
  --vimrc ) vimrc ; exit; ;;
  * ) echo "invalid argument: $1" && usage ; exit; ;;
esac
