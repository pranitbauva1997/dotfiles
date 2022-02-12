#!/bin/bash


# usage function
function usage()
{
   cat << BauvaDotfiles 

   Usage: $progname [--num NUM] [--time TIME_STR] [--verbose] [--dry-run]

   optional arguments:
     -h, --help           show this help message and exit
     -n, --num NUM        pass in a number
     -t, --time TIME_STR  pass in a time string
     -v, --verbose        increase the verbosity of the bash script
     --dry-run            do a dry run, dont change any files

HEREDOC
}  

# initialize variables
progname=$(basename $0)
verbose=0
dryrun=0
num_str=
time_str=

# use getopt and store the output into $OPTS
# note the use of -o for the short options, --long for the long name options
# and a : for any option that takes a parameter
OPTS=$(getopt -o "hn:t:v" --long "help,num:,time:,verbose,dry-run" -n "$progname" -- "$@")
if [ $? != 0 ] ; then echo "Error in command line arguments." >&2 ; usage; exit 1 ; fi
eval set -- "$OPTS"

while true; do
  # uncomment the next line to see how shift is working
  # echo "\$1:\"$1\" \$2:\"$2\""
  case "$1" in
    -h | --help ) usage; exit; ;;
    -n | --num ) num_str="$2"; shift 2 ;;
    -t | --time ) time_str="$2"; shift 2 ;;
    --dry-run ) dryrun=1; shift ;;
    -v | --verbose ) verbose=$((verbose + 1)); shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if (( $verbose > 0 )); then

   # print out all the parameters we read in
   cat <<EOM
   num=$num_str
   time=$time_str
   verbose=$verbose
   dryrun=$dryrun
EOM
fi

# PROJ_DIR=${PWD}
# VIM_DIR=${PWD}/vim
# GIT_DIR=${PWD}/git
# 
# Configure Vim
# echo "Configuring your favourite editor VIM\n"
# cd ${VIM_DIR}
# sh install.sh
# cd ${PROJ_DIR}

# Configure Git
# echo "Configuring your Git tool\n"
# cd ${GIT_DIR}
# sh install.sh
# cd ${PROJ_DIR}
