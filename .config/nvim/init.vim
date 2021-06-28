"""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'nvim-lua/completion-nvim'

Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'TimUntersberger/neogit'
Plug 'Yggdroot/indentLine'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

Plug 'morhetz/gruvbox'
Plug 'sainnhe/sonokai'

call plug#end()
lua require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
lua require('gitsigns').setup()


"""""""""""""""""""""""
" General
"""""""""""""""""""""""

set encoding=UTF-8
set nocompatible
set timeoutlen=1000 ttimeoutlen=0
set cursorline
set number

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Use the system clipboard
set clipboard=unnamed

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

"""""""""""""""""""""""
" VIM user interface
"""""""""""""""""""""""

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Show line numbers
set number

" Show the status bar
set laststatus=2

"Always show current position
set ruler

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
  autocmd GUIEnter * set vb t_vb=
endif

" Make the vsplit prettier
set fillchars+=vert:│
highlight VertSplit ctermbg=NONE guibg=NONE

" Skinny cursor in insert mode, fat cursor in normal mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


""""""""""""""""""""""
" Colors and Fonts
""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

let base16colorspace=256

" Enable true colors
if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"
" if has("termguicolors")
"   set termguicolors
" endif

" Configure theme
set background=dark

try
  colorscheme sonokai
catch
endtry

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set t_Co=256
  set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""
" Files
"""""""""""""""""""""""

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

nmap <Leader>ft :NvimTreeToggle<CR>

nmap <Leader>t :GFiles<CR>
nmap <Leader>r :Tags<CR>

nnoremap <leader>fed :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>qr :source ~/.config/nvim/init.vim<CR>

""""""""""""""""""""""
" Text
""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set softtabstop=2
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""
" Buffers
"""""""""""""""""""""""""""""

" Show buffers
nnoremap <leader>bb :Buffers<CR>

" Close the current buffer
map <leader>bd :bd<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Flip to previous buffer
map <leader><tab> :b#<CR>

" Move between open buffers
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger

""""""""""""""""""""""""""""
" Windows
""""""""""""""""""""""""""""

" Split normally
set splitbelow
set splitright

nnoremap <leader>w, <C-W>v
nnoremap <leader>w. <C-W>h
nnoremap <leader>wd :close<CR>

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>wj <C-W><C-J>
nnoremap <leader>wk <C-W><C-K>
nnoremap <leader>wl <C-W><C-L>
nnoremap <leader>wh <C-W><C-H>


""""""""""""""""""""""""
" Search
""""""""""""""""""""""""

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Clear highlight
nnoremap <leader><space> :noh<CR>

" Search the project for the visual selection
vnoremap <leader>sp "ky:Ag <C-R>k<CR>

" Search the current file for the visual selection
vnoremap <leader>ss "ky:Ag <C-R>k %<CR>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Telescope

nnoremap <leader>pf <cmd>Telescope find_files<cr>
nnoremap <D-p> <cmd>Telescope find_files<cr>
nnoremap <leader>pg <cmd>Telescope live_grep<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ms <cmd>builtin.lsp_workspace_symbols<cr>

" Completion

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c

nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>me <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>mE <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>ma <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>md <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>mf <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>mh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>mR <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>mr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>md <cmd>lua vim.lsp.buf.document_symbol()<CR>

nnoremap <leader>fpi :PlugInstall<CR>
nnoremap <leader>fpu :PlugUpdate<CR>

let g:indentLine_char = '│'
