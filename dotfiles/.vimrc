scriptencoding utf-8
" Complete javascript by showing arguments on hold
let g:tern_show_argument_hints='on_hold'
set updatetime=500
set noshowmode
" Let deoplete-tern and tern_for_vim cohabitate
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_show_loc_after_rename=0

let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_enable_es6 = 1

let g:javascript_plugin_jsdoc = 1

let g:UltiSnipsExpandTrigger='<F4>'
inoremap <c-x><c-k> <c-x><c-k>

" Display buffer line
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:base16colorspace=256
let g:airline_left_sep='' "  or  ?
let g:airline_right_sep='' "  or  ?
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.linenr = '¶'
let g:airline_theme='base16'
" Disable java makers for neomake. Neomake attempts to build huge projects,
" and prevents from closing vim/neovim before having completed the build
let g:neomake_java_enabled_makers = []

" Lint vue files correctly
let g:neomake_vue_enabled_makers = ['eslint']
let g:neomake_vue_eslint_maker = {
    \ 'args': ['-f', 'compact', '--plugin', 'vue'],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
        \ '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#'
\ }

" Do not run local vimrc onside sandbox
let g:localvimrc_sandbox=0
" Ask for local vimrc execution
let g:localvimrc_ask=1
" Save answer
let g:localvimrc_persistent=1

" Start deoplete on startup
" let g:deoplete#enable_at_startup = 1

" Set deoplete sources
set completeopt=longest,menuone ",preview
" let g:deoplete#sources = {}
" let g:deoplete#sources['javascript'] = ['file', 'ultisnips', 'ternjs', 'buffer']
" let g:deoplete#sources#ternjs#filetypes = ['javascript']
" let g:deoplete#sources#ternjs#docs = 1
" let g:deoplete#sources#ternjs#case_insensitive = 1
" let g:deoplete#sources#ternjs#include_keywords = 1

" Necessary for languageclient
set hidden
" always show sign columns
set signcolumn=yes
" Limit completion popup height
set pumheight=8

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'haskell': ['hie', '--lsp'],
    \ 'vue': ['vls'],
    \ 'python': ['pyls'],
    \ 'css': ['css-languageserver'],
    \ 'html': ['html-languageserver'],
    \ 'json': ['json-languageserver'],
    \ 'yaml': ['~/.npm-global/lib/node_modules/yaml-language-server/out/server/src/server.js'],
    \ }

let g:LanguageClient_diagnosticsDisplay = {}
let g:LanguageClient_diagnosticsDisplay#3 = {}
let g:LanguageClient_diagnosticsDisplay#3#signText = '➤'
let g:LanguageClient_diagnosticsDisplay#2 = {}
let g:LanguageClient_diagnosticsDisplay#2#signText = '⚠'

let g:neomake_warning_sign = {
    \   'text': '⚠',
    \   'texthl': 'NeomakeWarningSign',
    \ }
let g:neomake_message_sign = {
    \   'text': '➤',
    \   'texthl': 'NeomakeMessageSign',
    \ }

augroup JavascriptKeybingind
    au!
    " autocmd FileType javascript nnoremap <silent> <F2> :TernRename<CR>
    " autocmd FileType javascript nnoremap <silent> K :TernDoc<CR>
    autocmd FileType javascript nnoremap <silent> <C-]> :TernDef<CR>
augroup END
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <C-]> :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Automatically start language servers.
let g:LanguageClient_autoStart=1

set formatexpr=LanguageClient_textDocument_rangeFormatting()

" faster vim when in vue file
let g:vue_disable_pre_processors=1

" Do not conceal markdown
let g:markdown_syntax_conceal = 0
" Change highlighting in code blocks
let g:markdown_fenced_languages = ['html', 'python', 'javascript', 'css', 'haskell', 'arduino', 'c']

" Initialize Plug
call plug#begin()
" Load plugins
source ~/.vim/plug.vim
" Update runpath
call plug#end()

" Syntax colouring
syntax on

" Silent autocompletion
set shortmess+=c
filetype plugin indent on
" Stay silent when saving remote files
let g:netrw_silent=1

" Save with <Esc><Esc>
nnoremap <silent> <Esc><Esc> :w<CR>
" Timeout for escape characters. Reduces the delay before quitting insert mode
set ttimeoutlen=10
"Show help in a vertical tab instead of an horizontal one
cnoremap help vert bo help
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Open tagbar with <F8>
nmap <F8> :TagbarToggle<CR>
" Open NERDTree with <F6>
map <F6> :NERDTreeToggle<CR>
" Use tab and S-Tab to navigate through autocompletion
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-Tab>"
" Run Neomake on save
augroup NeomakeAugroup
    au!
    autocmd! BufWritePost * Neomake
    autocmd! BufEnter * Neomake
augroup END

" Ignore case when searching, except if search includes an uppercase char
set ignorecase
set smartcase

" Set the leader to be space (while keeping \)
map <Space> <Leader>

" Toggle highlightsearch on enter
nnoremap <CR> :set hlsearch!<CR>
" Quit with <leader>q
nnoremap <leader>q :q<CR>

" Disable folds on start
set nofoldenable
" Set foldmethod to syntax
set foldmethod=syntax

" Format on <F3> press
noremap <F3> :call LanguageClient_textDocument_formatting()<CR>
noremap <S-F3> :Autoformat<CR>

" Enable mouse
set mouse=a
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif
" Line numbers
set number
" Different hightlight for matchin parenthesis/brackets/...
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
" Show line numbers relative to the current line
set relativenumber
" Do not show the current mode as it is already being shown by Airline
set noshowmode
" Disable doublequotes hiding in json - to fix, doesn't work
set conceallevel=0
" Set dark theme, not light
set background=dark
" Open quickfix at the bottom
set splitbelow
" set colorscheme
set background=dark
colorscheme base16-eighties
set background=dark
" Always keep 5 lines above and below the cursor (when scrolling)
set scrolloff=5

" Transparent background
hi Normal guibg=NONE ctermbg=NONE
hi Statement guibg=NONE ctermbg=NONE
hi Title guibg=NONE ctermbg=NONE
hi Todo guibg=NONE ctermbg=NONE
hi Underlined guibg=NONE ctermbg=NONE
hi ErrorMsg guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
" Set window separation character
set fillchars+=vert:│
hi VertSplit guibg=NONE ctermbg=NONE ctermfg=green guifg=green

" Highlight characters after the 100 columns limit. Disabled by default
set colorcolumn=
hi ColorColumn ctermbg=None ctermfg=red

command ToggleColorColumn :let &cc = &cc == '' ? 100 : ''
" Show colorcolumn on <F10>
noremap <F10> :ToggleColorColumn<CR>

set inccommand=split

let g:gutentags_cache_dir = '/tmp/tags'
