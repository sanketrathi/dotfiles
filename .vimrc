"""""""""""""""""""""""""""""""""""""""""""""""""
""Rathi's awesomely amazingly spectacular vimrc""
"""""""""""""""""""""""""""""""""""""""""""""""""

" This must be first, because it changes other options as side effect
" Use Vim defaults (much better!)
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#infect()

filetype plugin indent on

Plugin 'esneider/YUNOcommit.vim'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Set default file encoding to unicode
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

" General defaults
let mapleader="\\"
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use for autoindenting
set expandtab     " use appropriate number of spaces when tabbing
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000  " remember more commands and search history
set undolevels=1000
                  " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title         " change the terminal's title
set nobackup      " don't write a backup file
set ruler         " show the cursor position all the time
set pastetoggle=<F2>
                  " toggle paste mode
nmap <f3> :set number! number?<cr>
                  " toggle showing line numbers
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
                  " highlight whitespace
nmap <silent> <Leader>= :nohlsearch <CR>
                  " unhighlight search
set viminfo='20,\"50
                  " Tell vim to remember certain things when we exit
set undofile      " Maintain undo history between session
set so=7          " Keep a scroll buffer ofr 7
nnoremap ; :
"set autochdir    " automatically changes directory to file in buffer
"set mouse=a      " Enable mouse support in console if you are into weird shit
"Magically move up and down in the same wrapped line!
"nnoremap j gj
"nnoremap k gk
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
iabbrev pdb from IPython.frontend.terminal.embed import InteractiveShellEmbed
\<CR>InteractiveShellEmbed()()

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"save files if you forgot to sudo
cmap w!! %!sudo tee > /dev/null %

"folds
set foldmethod=indent
set foldcolumn=0
set foldlevel=0
"set nofoldenable
nnoremap <space> za " space open/closes folds

" store backup and swp files in these dirs to not clutter working dir
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set undodir=~/.vim/undodir " undo file folder

"fix syntax highlighting for long files
autocmd BufEnter * :syntax sync minlines=200

"show current command in bottom line
set showcmd

" Cool tab completion stuff while entering commands
set wildmenu
set wildmode=list:longest,full

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Python
autocmd FileType python :nnoremap <Leader>c I#<Esc>

" Clisp
autocmd Filetype lisp setlocal ts=2 sts=2 sw=2

"Go
au BufRead,BufNewFile *.go set filetype=go

"Markdown
au BufRead,BufNewfile *.md set filetype=markdown
let g:instant_markdown_autostart = 0

" Javascript
"autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

" Django
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string


if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

" Use system clipboard (only works if compiled with +x)
set clipboard=unnamed

" Look and feel
set t_Co=256
set cursorline

"Colorscheme - badwolf, with some tweaks
colorscheme badwolf
let g:badwolf_darkgutter = 1
let g:badwolf_tabline = 2
let g:badwolf_css_props_highlight = 1


"Highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction


" Need to figure tab stuff some day
"tabs
"map <C-S-tab> :tabprevious<CR>
"map <C-tab> :tabnext<CR>
map th :tabfirst<CR>
map tl :tablast<CR>
map tt :tabfind<Space>
map tn :tabnext<Space>
map tm :tabm<Space>
map <C-n> :NERDTreeToggle<CR>

autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 0
autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 0
autocmd BufReadPre *.js let b:javascript_lib_use_prelude = 0
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1
autocmd CompleteDone * pclose
