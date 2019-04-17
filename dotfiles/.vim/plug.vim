Plug 'Shougo/context_filetype.vim'
Plug 'chriskempson/base16-vim'
" Git gutter
" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
" Smooth scrolling
Plug 'yuttie/comfortable-motion.vim'
" Completion manager
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'roxma/nvim-completion-manager'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" Tern support
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
" Tern completion
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" fzf fuzzy finder
" Plug 'junegunn/fzf.vim'
" Surround with cs'"
Plug 'tpope/vim-surround'
" Auto match brackets and other things.
Plug 'jiangmiao/auto-pairs'
" Beautifier
Plug 'zeekay/vim-beautify'
Plug 'Chiel92/vim-autoformat'
" Comment stuff out
" Plug 'tpope/vim-commentary'
Plug 'tyru/caw.vim'
" Table mode
Plug 'dhruvasagar/vim-table-mode'
" Markdown plugin for tables
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
" Abolish - abbreviations
Plug 'tpope/vim-abolish'
" Unimpaired
Plug 'tpope/vim-unimpaired'
" NERDtree
Plug 'scrooloose/nerdtree'
" Fugitive - Git wrapper
Plug 'tpope/vim-fugitive'
" JSDoc
Plug 'heavenshell/vim-jsdoc'
" Add snippets.
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Emmet snippets
Plug 'mattn/emmet-vim'
" Airline
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Neomake, syntax checker
Plug 'neomake/neomake'
" Ctags creation
" Plug 'ludovicchabant/vim-gutentags'
" Tagbar
Plug 'majutsushi/tagbar'
" Gentoo files syntax
Plug 'gentoo/gentoo-syntax'
" Javascript
Plug 'pangloss/vim-javascript'
" Latex
" Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'lervag/vimtex'
" Vue.js
Plug 'posva/vim-vue'
" Fish
Plug 'dag/vim-fish'
" PlatformIO Neomake plugin
Plug 'platformio/neomake-platformio', { 'do': ':UpdateRemotePlugins' }
" Support local vimrc files
Plug 'embear/vim-localvimrc'
" Html highlighting
Plug 'othree/html5.vim'
" Ocaml indentation
" Plug 'vim-scripts/omlet.vim'
" Haskell syntax file
Plug 'neovimhaskell/haskell-vim'

" Jupyter/IPython
Plug 'bfredl/nvim-ipy'

" Multiple syntaxes
" Plug 'sheerun/vim-polyglot'

" Discord Rich Presence
" Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
" Plug 'anned20/vimsence'

" Code formatting
Plug 'sbdchd/neoformat'

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
