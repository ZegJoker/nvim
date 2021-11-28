" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: Stanley Xiao 

" ===
" " === Auto load for first time uses
" " ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
						 \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Dress up
Plug 'altercation/vim-colors-solarized'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'ojroques/vim-scrollstatus'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'theniceboy/vim-snippets'

" Code format
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'

" Markdown
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode'
Plug 'mzlogin/vim-markdown-toc' 

" Editor Enhancement Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'aperezdc/vim-template'

" File navigation
Plug 'luukvbaal/nnn.nvim'

" Flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'f-person/pubspec-assist-nvim', { 'for' : ['pubspec.yaml'] }

call plug#end()

lua << EOF
require("nnn").setup()
EOF

let mapleader=" "


" Feature config
set number
set relativenumber
set wildmenu
set hidden
set hlsearch
exec "nohlsearch"
set incsearch
set noshowmode
set showcmd
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=5
set noexpandtab
set laststatus=2
set encoding=utf-8

" Dress up
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
colorscheme solarized
colors solarized
hi Pmenu ctermbg=15
hi PmenuSel ctermbg=15
hi Pmenu guibg=DarkCyan

" Key config
noremap <LEADER>c "+y
noremap <LEADER>v "+gp
noremap <LEADER>w :w<CR>
noremap <LEADER>q :q<CR>
nmap ∆ 15gj
nmap ˚ 15gk
nmap zj o<Esc>k
nmap zk O<Esc>j
vmap Q gq
nmap Q gqap
noremap <LEADER>n <cmd>NnnExplorer<CR>
nnoremap <LEADER>n <cmd>NnnExplorer %:p:h<CR>
nnoremap <LEADER>p <cmd>NnnPicker<CR>


" Plugins config
let g:instant_markdown_port=10055
let g:instant_markdown_autostart=0
let g:airline_section_x = '%{ScrollStatus()}'
" Template
let g:username = 'Stanley Xiao'
let g:email = "stanley.coder@gmail.com"
let g:templates_use_licensee = '0'


" ===
" === coc.nvim
" ===
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-diagnostic',
	\ 'coc-explorer',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-prettier',
	\ 'coc-prisma',
	\ 'coc-pyright',
	\ 'coc-python',
	\ 'coc-snippets',
	\ 'coc-sourcekit',
	\ 'coc-stylelint',
	\ 'coc-syntax',
	\ 'coc-tailwindcss',
	\ 'coc-tasks',
	\ 'coc-translator',
	\ 'coc-tslint-plugin',
	\ 'coc-tsserver',
	\ 'coc-vetur',
	\ 'coc-vimlsp',
	\ 'coc-yaml',
	\ 'coc-yank']


function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'
