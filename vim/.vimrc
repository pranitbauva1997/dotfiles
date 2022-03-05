filetype on
filetype plugin indent on
set encoding=utf-8
set fileencoding=utf-8
set number
set relativenumber
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
syntax enable
set lazyredraw
set showmatch
set spell
set hlsearch
colorscheme pablo

" Set custom indent width for particular filetype
autocmd Filetype html set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype css set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype javascript set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype javascriptreact set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype typescript set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype typescriptcommon set shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype typescriptreact set shiftwidth=2 softtabstop=2 tabstop=2

autocmd Filetype make set noexpandtab

" Set spell check for markdown and text file
autocmd Filetype markdown set spell
autocmd Filetype markdown_tablemode set spell
autocmd Filetype text set spell

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" Set folding
set foldmethod=indent

set backspace=indent,eol,start

" Language
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" Plugin Configurations
"
" Vim Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Golang configs
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

" Vim fugitive
nmap <Leader>gd :Git diff<CR>
nmap <Leader>gl :Git log<CR>
nmap <Leader>gb :Git blame<CR>

" Terraform file configs
let g:terraform_fmt_on_save = 1
let g_terraform_align = 1

" Snippets and Code completion
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<C-l>"

" Closetags Plugin config
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,javascript,javascript.jsx,typescript,typescript.tsx'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

" Javascript Plugin config
set conceallevel=1
let g:javascript_plugin_jsdoc = 1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

" NERDTree Mappings
nmap <Leader>nt :NERDTree<CR>

" Vim Gutter
set updatetime=250

" Vim Gutter Mappings
nmap <Leader>gn :GitGutterNextHunk<CR>
nmap <Leader>gp :GitGutterPrevHunk<CR>
nmap <Leader>gv :GitGutterPreviewHunk<CR>

" Remember folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END
