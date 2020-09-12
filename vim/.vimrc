filetype on
filetype plugin indent on
set number
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
syntax enable
set lazyredraw
set showmatch
set spell
colorscheme pablo

" Mappings
map <C-n> :NERDTree<CR>

" Plugin Configurations
"
" Vim Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
