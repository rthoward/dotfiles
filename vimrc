"""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""

if filereadable(expand("~/.vim/vimrc.bundles"))
  source ~/.vim/vimrc.bundles
end

"""""""""""""""""""""""
" General
"""""""""""""""""""""""

" Use UTF-8 encoding
set encoding=UTF-8

set nocompatible
set timeoutlen=1000 ttimeoutlen=0

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

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" Enable true colors
if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if has("termguicolors")
  set termguicolors
endif

" Configure theme
set background=dark

try
  colorscheme palenight
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

nmap <Leader>F :NERDTreeToggle<CR>

nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>R :source ~/.vimrc<CR>

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
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Flip to previous buffer
map <leader><tab> :b#<CR>

" Move between open buffers
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Switch CWD to the directory of the open buffer
nmap ; :Buffers<CR>
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""
" Windows
""""""""""""""""""""""""""""

" Split normally
set splitbelow
set splitright

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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

" Use ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" incremental search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Project-wide search
nnoremap <leader>sp :Ag<space>

" Clear highlight
nnoremap <leader><space> :noh<CR>

" Search the project for the visual selection
vnoremap <leader>sp "ky:Ag <C-R>k<CR>

" Search the current file for the visual selection
vnoremap <leader>ss "ky:Ag <C-R>k %<CR>

""""""""""""""""""""""
" Linting
""""""""""""""""""""""

let g:ale_completion_enabled = 1

let g:ale_linters = {
    \ 'javascript': ['prettier', 'eslint'],
    \ 'ruby': ['ruby'],
    \ 'typescript': ['prettier', 'tslint', 'tsserver'],
    \ 'eruby': [],
    \ 'elixir': [],
    \ 'python': ['flake8'],
    \}

let g:ale_fixers = {
    \ 'javascript': ['eslint'],
    \ 'ruby': ['rubocop'],
    \ 'typescript': ['tslint'],
    \ 'elixir': ['mix_format'],
    \}

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'

highlight ALEErrorSign   guibg=NONE guifg=red ctermbg=NONE ctermfg=red
highlight ALEWarningSign guibg=NONE guifg=yellow ctermbg=NONE ctermfg=yellow

nnoremap <leader>af :ALEFix<CR>

""""""""""""""""""""""
" Status line
""""""""""""""""""""""

let g:lightline = {}

" Set the colorscheme
let g:lightline.colorscheme = 'palenight'

" Integrate with ALE
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \  'linter_checking': 'left',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \  'linter_ok': 'left',
      \ }

let g:lightline.active = {
      \ 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
      \ }

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

let g:project_dirs = [
  \ '/Users/richard/code/dds/atst',
  \ ]

if index(g:project_dirs, getcwd()) != -1
  try
    source .pvimrc
  catch
  endtry
endif

let g:pymode = 0
let g:pymode_lint = 0
