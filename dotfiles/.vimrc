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

" Gray color for limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'

augroup GoyoLimelight
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight! | call TransparentBg()
augroup END

nnoremap <leader>g :Goyo<CR>
nnoremap <leader>lm :Limelight!!<CR>

let g:polyglot_disabled = ['tex', 'latex']
let g:vimtex_complete_enabled = 0
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_syntax_minted = [
            \ {
            \   'lang' : 'haskell',
            \ },
            \]
let g:vimtex_quickfix_open_on_warning = 0
let g:latex_view_general_viewer = 'zathura'
let g:vimtex_view_method = "zathura"
nmap <leader>ls <Plug>(vimtex-compile-ss)

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)

" Disable java makers for neomake. Neomake attempts to build huge projects,
" and prevents from closing vim/neovim before having completed the build
let g:neomake_java_enabled_makers = []
let g:neomake_tex_enabled_makers = []

" Lint vue files correctly
let g:neomake_vue_enabled_makers = ['eslint']
let g:neomake_vue_eslint_maker = {
            \ 'args': ['-f', 'compact', '--plugin', 'vue'],
            \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
            \ '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#'
            \ }

let g:tex_fold_enabled = 0

" Do not run local vimrc onside sandbox
let g:localvimrc_sandbox=0
" Ask for local vimrc execution
let g:localvimrc_ask=1
" Save answer
let g:localvimrc_persistent=1

" Start deoplete on startup
let g:deoplete#enable_at_startup = 1

" Set deoplete sources
set completeopt=longest,menuone ",preview
" let g:deoplete#sources = {}
" let g:deoplete#sources['javascript'] = ['file', 'ultisnips', 'ternjs', 'buffer']
" let g:deoplete#sources#ternjs#filetypes = ['javascript']
" let g:deoplete#sources#ternjs#docs = 1
" let g:deoplete#sources#ternjs#case_insensitive = 1
" let g:deoplete#sources#ternjs#include_keywords = 1

" Trailing whitespace
set list
set listchars=tab:>.,trail:-,extends:#,nbsp:.

" Necessary for languageclient
set hidden
" always show sign columns
if has('signcolumn')
    set signcolumn=yes
end
" Limit completion popup height
set pumheight=8

let g:LanguageClient_serverCommands = {
            \ 'javascript': ['typescript-language-server', '--stdio'],
            \ 'haskell': ['hie', '--lsp'],
            \ 'vue': ['vls'],
            \ 'python': ['pyls'],
            \ 'lean': ['lean-language-server', '--stdio'],
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

" Automatically start language servers.
let g:LanguageClient_autoStart=1

" faster vim when in vue file
let g:vue_disable_pre_processors=1

" Do not conceal markdown
let g:markdown_syntax_conceal = 0
" Change highlighting in code blocks
let g:vim_markdown_fenced_languages = ['html', 'python', 'javascript', 'css', 'haskell', 'arduino', 'c', 'json']

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
set conceallevel=0
" Enable truecolor
set termguicolors
" Set dark theme, not light
set background=dark
" Open quickfix at the bottom
set splitbelow
" set colorscheme
set background=dark
colorscheme base16-eighties
" colorscheme base16-apathy
set background=dark
" Always keep 5 lines above and below the cursor (when scrolling)
set scrolloff=5

function TransparentBg()
    " Transparent background
    hi Normal guibg=NONE ctermbg=NONE
    hi Statement guibg=NONE ctermbg=NONE
    hi Title guibg=NONE ctermbg=NONE
    hi Todo guibg=NONE ctermbg=NONE
    hi Underlined guibg=NONE ctermbg=NONE
    hi ErrorMsg guibg=NONE ctermbg=NONE
    hi LineNr guibg=NONE ctermbg=NONE
    hi SignColumn guibg=NONE ctermbg=NONE
endfunction

call TransparentBg()

" Set window separation character
set fillchars+=vert:│
hi VertSplit guibg=NONE ctermbg=NONE ctermfg=green guifg=green

" Highlight characters after the 100 columns limit. Disabled by default
set colorcolumn=
hi ColorColumn ctermbg=None ctermfg=red

command ToggleColorColumn :let &cc = &cc == '' ? 100 : ''
" Show colorcolumn on <F10>
noremap <F10> :ToggleColorColumn<CR>

if has('nvim')
    set inccommand=nosplit
endif

let g:grammalecte_cli_py = '~/Downloads/grammalecte/grammalecte-cli.py'
let g:gutentags_cache_dir = '/tmp/tags'

fun LatexSkeleton()
    put ='\documentclass{article}'
    put =''
    put ='\usepackage[utf8]{inputenc}'
    put ='\usepackage[T1]{fontenc}'
    put ='\usepackage[french]{babel}'
    put ='\usepackage[a4paper, margin=2cm]{geometry}'
    put ='\usepackage{amsmath}'
    put ='\usepackage{amssymb}'
    put ='\usepackage{amsthm}'
    put ='\usepackage{stmaryrd}'
    put ='\usepackage{color}'
    put ='\usepackage[hidelinks]{hyperref}'
    put =''
    put ='\title{}'
    put ='\author{}'
    put ='\date{}'
    put =''
    put ='\begin{document}'
    put =''
    put ='% \maketitle'
    put ='% \tableofcontents'
    put =''
    put ='\end{document}'
    normal! ggdd
    /title/
    set nohlsearch
    exec 'normal! f{'
endfun

let g:LatexBox_latexmk_preview_continuously=1

augroup LatexFiletypeGroup
    au!
    autocmd BufEnter *.tex silent set ft=tex
    autocmd BufNewFile *.tex silent call LatexSkeleton()
    " autocmd FileType tex silent set updatetime=3000
    autocmd CursorHold *.tex silent :up
    " Use gk and gj to move around the file instead of j and k
    autocmd FileType tex silent noremap k gk
    autocmd FileType tex silent noremap j gj
augroup END

augroup Vue
    autocmd FileType vue syntax sync fromstart
augroup END

augroup ConfigReload
    au!
    " autocmd BufWritePost .compton.conf silent :!killall picom; and setsid picom
    autocmd BufWritePost ~/.config/i3/config silent :!i3-msg reload
    autocmd BufWritePost .tmux.conf silent :!tmux source-file ~/.tmux.conf
    autocmd BufWritePost ~/.config/polybar/config :!~/bin/reload-polybar
augroup END
