all: vim git bin
	# TODO: ./install.sh (--all)
	echo "This will install all the configs in full settings\n"

vim: vim-plugin vimrc 
	echo "this will install all vim configs in full settings\n"

vimrc:
	# TODO: ./install.sh (--vimrc)
	echo "This will install all the vim configs and store in ~/.vimrc\n"

vim-plugin:
	# TODO: ./install.sh (--vim-plugin)
	echo "This will install all the vim plugins in ~/.vim folder\n"

bin:
	# TODO: ./install.sh (--bin)
	echo "This will install all the custom scripts I have created and\n"
	echo "to make my life in terminal easier. This is also a good\n"
	echo "alternative to store particular bash snippet documentation\n"
	echo "which can act as template for scripts made to run in production\n"

help:
	# TODO: ./install.sh [-h | --help]
	echo "This should show the help menu for install.sh script"
