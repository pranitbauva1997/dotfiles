filetype on
filetype plugin indent on
set encoding=utf-8
set fileencoding=utf-8
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

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" Mappings
map <C-n> :NERDTree<CR>

" Plugin Configurations
"
" Vim Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Golang configs
" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"

" Enable autocomplete prompt to appear automatically when dot (.) is pressed
" au filetype go inoremap <buffer> . .<C-x><C-o>

" Automatically get signature/type info for object under cursor
let g:go_auto_type_info = 1

" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" Terraform file configs
let g:terraform_fmt_on_save = 1
let g_terraform_align = 1
