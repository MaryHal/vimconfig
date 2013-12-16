"===============================================================================
" => Pre-init
"===============================================================================
set nocompatible               " Be iMproved

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" In Windows/Linux, take in a difference of ".vim" and "$VIM/vimfiles".
let $DOTVIM = expand('~/.vim')

"===============================================================================
" => Plugins
"===============================================================================
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build': {
      \ 'windows': 'make -f make_mingw32.mak',
      \ 'cygwin': 'make -f make_cygwin.mak',
      \ 'mac': 'make -f make_mac.mak',
      \ 'unix': 'make -f make_unix.mak',
      \ } }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-help'

NeoBundle 'Shougo/vimfiler.vim'

" Completion
NeoBundle 'Valloric/YouCompleteMe'
" NeoBundle 'Shougo/neocomplete.vim'

" Commenter
NeoBundle 'tomtom/tcomment_vim'

" Buffers, Tabs, and such
NeoBundle 'a.vim'
NeoBundle 'bufkill.vim'

NeoBundle 'rking/ag.vim'

" Usability
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-rsi'
NeoBundle 'sjl/gundo.vim'

" Color Scheme plugins and appearance
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'bling/vim-airline'

" Filetype plugins
NeoBundle 'tpope/vim-markdown'
NeoBundle 'jceb/vim-orgmode'

" Load local plugins
execute 'NeoBundleLocal' '~/.vim/local'

filetype plugin indent on " required!

NeoBundleCheck            " Installation check.

"===============================================================================
" => General
"===============================================================================
set nocompatible

" Sets how many lines of history VIM has to remember
set history=1000

" Enable filetype plugin
filetype plugin on
filetype indent on

set encoding=utf-8

" Set to auto read when a file is changed from the outside
set autoread

set hidden

" Allow Mouse Usage
set mouse=a

" Let's use ag instead of grep!
set grepprg=ag

" Make with 2 cores
set makeprg=make\ -j2

if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

set ttyfast
"set ttyscroll=0
set ttimeout
set ttimeoutlen=50

set autoread
set autowrite

" Turn off cursor blinking
set guicursor=a:blinkon0

"===============================================================================
" => VIM user interface
"===============================================================================
set shortmess=Iat

" Solid line for vsplit separator
set fcs=vert:│

" Ask for confirmation for various things
set confirm

" Don't complete from other buffer
set complete=.

" Set 3 lines to pad the cursor - when moving vertical..
set scrolloff=10
set sidescrolloff=5

" Auto complete setting
set completeopt=longest,menuone

set wildmenu " Turn on Wild menu
set wildmode=list:longest,full

set wildignore=*.o,*.pyc,*.hi
set wildignore+=.hg,.git,.svn,.gitignore         " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.d                              " dependency files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX BS

set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code

set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*.pdf

set ruler "Always show current position

" Line Numbers
" set number

" Set backspace config
set backspace=eol,start,indent
" set whichwrap+=<,>,h,l

" Searching
set ignorecase "Ignore case when searching
set smartcase  "If there are any capitalized letters, case sensitive search

set nohlsearch "Don't Highlight search things
set incsearch  "Make search act like search in modern browsers
set wrapscan   " Search wraps around the end of the file

set gdefault "substitute default = all matches on line

set showmatch "Show matching bracets when text indicator is over them
set matchtime=5

set virtualedit=onemore

" Show incomplete commands
set showcmd

" No need to show mode due to Powerline / Statusline modifications
set noshowmode

set modelines=0

" Disable all bells
set noerrorbells novisualbell t_vb=

set lazyredraw

"===============================================================================
" => Files and backups
"===============================================================================
set nowritebackup
set nobackup
set noswapfile

if has('persistent_undo')
    set undodir='~/.vim/cache/undo/'
    "set undofile
    set undolevels=1000
    if exists('+undoreload')
        set undoreload=1000
    endif
endif
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files

"===============================================================================
" => Text, tab and indent related
"===============================================================================
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set autoindent
set smartindent
" set cindent

set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,eol:¬,trail:·
set showbreak=↪

set wrap
set whichwrap+=h,l,<,>,[,]
set linebreak
" set tw=500

"===============================================================================
" => Moving around, tabs and buffers
"===============================================================================
set splitright
set splitbelow

" Multiple buffer stuff
"set switchbuf=useopen
set switchbuf=usetab

" Mapleader and localleader.
let mapleader = ","
let maplocalleader = ","

" When pressing <leader>cd switch to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<CR>

" Open terminal in current directory
nnoremap <leader>t :!$TERMINAL<CR><CR>

" Easy buffer navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Fast Tab Switching?
" nmap <silent> J gT
" nmap <silent> K gt

" Make K match J
nmap K kJ

" Window sizes always equal on split or close
set equalalways

" line wrap movement
noremap j gj
noremap k gk

" Reselect visual block after indent
xnoremap < <gv
xnoremap > >gv

" Delete into the blackhole register to not clobber the last yank
"nnoremap d "_d
" I use this often to yank a single line, retain its original behavior
"nnoremap dd dd

"map H ^
"map L g_

"nmap <silent> <C-S-w> :wincmd<Space>

" Bracket matching made easy?
"nnoremap <tab> %
"vnoremap <tab> %

" Tab Switching (non-terminal vim only)
"nmap <C-S-tab> :tabp<CR>
"nmap <C-tab>   :tabn<CR>

"===============================================================================
" => Other Key Remapping
"===============================================================================

" Fix broken vim regexes when searching
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s/ s/\v

" set magic

" Make Y consistent with C and D. See :help Y.
nnoremap Y y$

" Less chording, swap ; and :
" nnoremap ; :
" nnoremap : ;
" vnoremap ; :
" vnoremap : ;

" Leader keys
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>

" Sudo to write
"cmap W!! w !sudo tee % >/dev/null

" Avoid Typos
silent! command -nargs=0 W w
silent! command -nargs=0 Q q
silent! command -nargs=0 WQ x
silent! command -nargs=0 Wq x

"===============================================================================
" => Insert Mode Key Remapping
"===============================================================================
" map control-backspace to delete the previous word
" imap <C-BS> <C-W>

" Escape is far...
imap jk <ESC>
imap kj <ESC>

"===============================================================================
" => Autocommands
"===============================================================================
if has('autocmd')
    " Resize splits when window is resized
    au VimResized * exe "normal! \<c-w>="

    " Html settings
    autocmd FileType html setlocal shiftwidth=2 tabstop=2
endif

"===============================================================================
" => Colors and Fonts
"===============================================================================
syntax enable

if !has('gui_running')
  set t_Co=256
endif

" set background=dark
" colorscheme base16-default

let g:hybrid_use_Xresources = 1
colorscheme hybrid

" Set font
if has("win32") || has('win64')
    set guifont=Consolas:h8:cANSI
else
    set guifont=Inconsolata\ 10
endif

set guioptions=acg
set fileformat=unix
set ffs=unix,dos,mac "Default file types

"===============================================================================
" => Statusline
"===============================================================================

" Always show the statusline
set laststatus=2

" Airline
let g:airline_enable_branch=0
let g:airline_enable_syntastic=0
let g:airline_enable_tagbar=0
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_whitespace=0
let g:airline_detect_iminsert=0

" Theme
let g:airline_inactive_collapse=1
let g:airline_powerline_fonts=0
let g:airline_theme='wombat'

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_alt_sep=''
let g:airline_linecolumn_prefix = '¶ '

let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'Normal',
            \ 'i'  : 'Insert',
            \ 'R'  : 'Replace',
            \ 'c'  : 'Command',
            \ 'v'  : 'Visual',
            \ 'V'  : 'Visual-Line',
            \ '' : 'Visual-Block',
            \ 's'  : 'Select',
            \ 'S'  : 'Select-Line',
            \ '' : 'Select-Block',
            \ }

" Smart Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

"===============================================================================
" => Autocommands
"===============================================================================

augroup MyAutoCmd
    " Turn on cursorline only on active window
    " autocmd WinLeave * setlocal nocursorline
    " autocmd WinEnter,BufRead * setlocal cursorline
augroup END

" q quits in certain page types. Don't map esc, that interferes with mouse input
autocmd MyAutoCmd FileType help,quickrun
      \ if (!&modifiable || &ft==#'quickrun') |
      \ nnoremap <silent> <buffer> q :q<cr>|
      \ nnoremap <silent> <buffer> <esc><esc> :q<cr>|
      \ endif
autocmd MyAutoCmd FileType qf nnoremap <silent> <buffer> q :q<CR>

"===============================================================================
" => Plugin Settings
"===============================================================================
nmap <F1> [unite]h
nmap <F2> :<C-u>VimFiler<CR>
nmap <F3> :<C-u>GundoToggle<CR>

map <F5> :call CompileAndRun(0)<CR>
map <F6> :call CompileAndRun(1)<CR>
map <F7> :call Premake()<CR>

" map <F7> :!ctags --verbose=yes -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"===============================================================================
" => YCM
"===============================================================================

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_filetype_blacklist = {
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'text' : 1,
      \ 'unite' : 1
      \}

"===============================================================================
" => Unite
"===============================================================================

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])

" Set up some custom ignores
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'git5/.*/review/',
      \ 'google/obj/',
      \ ], '\|'))

" Map space to the prefix for Unite
nnoremap [unite] <Nop>
nmap <space> [unite]

" General fuzzy search
nnoremap <silent> [unite]<space> :<C-u>Unite
      \ -buffer-name=files buffer file_mru bookmark file<CR>

" Quick registers
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" Quick buffer
nnoremap <silent> [unite]u :<C-u>Unite -buffer-name=buffers buffer<CR>

" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>

" Quick outline
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline -vertical outline<CR>

" Quick sessions (projects)
" nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions session<CR>

" Quick sources
nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources source<CR>

" Quick snippet
" nnoremap <silent> [unite]s :<C-u>Unite -buffer-name=snippets snippet<CR>

" Quickly switch lcd
nnoremap <silent> [unite]d :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory<CR>
nnoremap <silent> [unite]D
      \ :<C-u>UniteWithCurrentDir -buffer-name=change-cwd -default-action=lcd directory<CR>
nnoremap <silent> [unite]<C-d>
      \ :<C-u>UniteWithBufferDir -buffer-name=change-cwd -default-action=lcd directory<CR>

" Quick file search
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]F :<C-u>UniteWithCurrentDir -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]<C-f> :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>

" Quick Recursive File Search
nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=files file_rec/async <CR>

" Quick grep from cwd
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=grep grep:.<CR>

" Quick help
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>

" Quick line using the word under cursor
nnoremap <silent> [unite]l :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>

" Quick MRU search
" nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>

" Quick find
nnoremap <silent> [unite]n :<C-u>Unite -buffer-name=find find:.<CR>

" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>

" Quick bookmarks
" nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=bookmarks bookmark<CR>

" Fuzzy search from current buffer
" nnoremap <silent> [unite]b :<C-u>UniteWithBufferDir
" \ -buffer-name=files -prompt=%\ buffer file_mru bookmark file<CR>

" Quick commands
" nnoremap <silent> [unite]; :<C-u>Unite -buffer-name=history history/command command<CR>

" Custom Unite settings
autocmd MyAutoCmd FileType unite call s:unite_settings()
function! s:unite_settings()

  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <ESC> <Plug>(unite_exit)
" imap <buffer> <c-j> <Plug>(unite_select_next_line)
  imap <buffer> <c-j> <Plug>(unite_insert_leave)
  nmap <buffer> <c-j> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <c-k> <Plug>(unite_loop_cursor_up)
  imap <buffer> <c-a> <Plug>(unite_choose_action)
  imap <buffer> <Tab> <Plug>(unite_exit_insert)
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
  imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
  imap <buffer> ' <Plug>(unite_quick_match_default_action)
  nmap <buffer> ' <Plug>(unite_quick_match_default_action)
  nmap <buffer> <C-r> <Plug>(unite_redraw)
  imap <buffer> <C-r> <Plug>(unite_redraw)
  inoremap <silent><buffer><expr> <C-x> unite#do_action('split')
  nnoremap <silent><buffer><expr> <C-x> unite#do_action('split')
  inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')

  let unite = unite#get_current_unite()
  if unite.buffer_name =~# '^search'
    nnoremap <silent><buffer><expr> r unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd unite#do_action('lcd')

" Using Ctrl-\ to trigger outline, so close it using the same keystroke
  if unite.buffer_name =~# '^outline'
    imap <buffer> <C-\> <Plug>(unite_exit)
  endif

" Using Ctrl-/ to trigger line, close it using same keystroke
  if unite.buffer_name =~# '^search_file'
    imap <buffer> <C-_> <Plug>(unite_exit)
  endif
endfunction

" Start in insert mode
let g:unite_enable_start_insert = 1

" Enable short source name in window
" let g:unite_enable_short_source_names = 1

" Enable history yank source
let g:unite_source_history_yank_enable = 1

" Open in bottom right
let g:unite_split_rule = "botright"

" Data directory location
let g:unite_data_directory = expand('~/.vim/cache/unite')

" Shorten the default update date of 500ms
let g:unite_update_time = 200

let g:unite_source_file_mru_limit = 1000
let g:unite_cursor_line_highlight = 'TabLineSel'
" let g:unite_abbr_highlight = 'TabLine'

let g:unite_source_file_mru_filename_format = ':~:.'
let g:unite_source_file_mru_time_format = ''

" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" vnoremap <silent> <leader><space> :call AceJumpWord(1)<CR>
nnoremap <silent> [unite]<space> :call AceJumpWord(0)<CR>
nnoremap <silent> [unite]k       :call AceJumpLine(0)<CR>
nnoremap <silent> [unite]j       :call AceJumpChar(0)<CR>

"===============================================================================
" => VimFiler
"===============================================================================

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_data_directory = expand('~/.vim/cache/vimfiler')

" Icons
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
" let g:vimfiler_file_icon = ' '
let g:vimfiler_marked_file_icon = '✓'
" let g:vimfiler_readonly_file_icon = ' '

"===============================================================================
" => Functions
"===============================================================================
function! Premake()
    exec '!premake4 gmake'
endfunction

function! CompileAndRun(runProgram)
    let l:progname = './' . expand('%:t:r')
    let l:interpreter = 0
    let l:domake = 1
    let l:runner = './run'

    " Otherwise :make won't return a proper exit status.
    setl shellpipe=2>&1\ \|\ tee\ %s;exit\ \${PIPESTATUS[0]}

    " Find out how to build the program.
    if filereadable("SConstruct")
        setl makeprg=scons
    elseif filereadable("Makefile") || filereadable("makefile")
        setl makeprg=make\ -j\ -k
    elseif filereadable("build.xml")
        setl makeprg=ant
    elseif &filetype == 'c'
        setl makeprg=gcc\ -Wall\ -std=c99\ \ -o\ %<\ %
    elseif &filetype == 'cpp'
        setl makeprg=g++\ -Wall\ -std=c++11\ -o\ %<\ %
    elseif &filetype == 'java'
        setl makeprg=javac\ %
        let l:progname = 'java ' . expand('%:t:r')
        let l:interpreter = 1
    elseif &filetype == 'tex'
        setl makeprg=pdflatex\ %\ \-file\-line\-error\ \-interaction=nonstopmode
    else
        " Assume it's a simple script.
        let l:progname = './' . expand('%')
        let l:domake = 0
    endif

    write
    if l:domake == 1
        silent !echo -e "\n\nBuilding..."
        make
        cw
    else
        silent !echo -e "\n\nNot running build tool."
    endif

    if v:shell_error == 0 && a:runProgram == 1
        if executable(l:runner)
            silent !echo -e "\n\nExecuting run script..."
            exec '!' . l:runner
        elseif executable(l:progname) || l:interpreter == 1
            silent exec '!echo -e "\n\nExecuting \"' . l:progname . '\""...'
            exec '!' . l:progname
        endif
    endif
endfunction

function! DeleteTrailingWhiteSpace()
    %s/\s\+$//e
endfunction

