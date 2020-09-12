#!/bin/bash

PROJ_DIR=$PWD
VIM_DIR=$PWD/vim

# Configure Vim
echo "Configuring your favourite editor VIM\n"
cd $VIM_DIR
sh install.sh
