"===============================================================================
" => Pre-init
"===============================================================================
let s:starting = has('vim_starting')
if s:starting
    " ensure that we always start with Vim defaults (as opposed to those set by the current system)
    set all&
    " caution: this resets many settings, eg 'history'
    set nocompatible
endif

let s:is_cygwin = has('win32unix') || has('win64unix')
let s:is_windows = has('win32') || has('win64')
let s:is_mac = has('gui_macvim') || has('mac')
let s:is_msysgit = (has('win32') || has('win64')) && $TERM ==? 'cygwin'
let s:is_tmux = !empty($TMUX)
let s:is_ssh = !empty($SSH_TTY)
let s:lua_patch885 = has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
" let s:has_eclim = isdirectory(expand("~/.vim/eclim", 1))
" let s:plugins=isdirectory(expand("~/.vim/bundle/vundle", 1))

if s:starting && s:is_windows && !s:is_cygwin && !s:is_msysgit
    set runtimepath+=~/.vim/
endif

" 'is GUI' means vim is _not_ running within the terminal.
" sample values:
" &term = win32 //vimrc running in msysgit terminal
" $TERM = xterm-color , cygwin
" &term = builtin_gui //*after* vimrc but *before* gvimrc
" &shell = C:\Windows\system32\cmd.exe , /bin/bash
let s:is_gui = has('gui_running') || strlen(&term) == 0 || &term ==? 'builtin_gui'

"===============================================================================
" => Plugins
"===============================================================================
execute pathogen#infect('bundle/{}')
syntax on
filetype plugin indent on

"===============================================================================
" => Functions
"===============================================================================
function! Premake()
    exec '!premake4 clean'
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
        setl makeprg=make
    elseif filereadable("build.xml")
        setl makeprg=ant
    elseif &filetype == 'c'
        setl makeprg=gcc\ -Wall\ -std=c99\ \ -o\ %<\ %
    elseif &filetype == 'cpp'
        setl makeprg=g++\ -Wall\ -std=c++1y\ -o\ %<\ %
        " elseif &filetype == 'java'
        "     setl makeprg=javac\ %
        "     let l:progname = 'java ' . expand('%:t:r')
        "     let l:interpreter = 1
    elseif &filetype == 'tex'
        " Background process of:
        " latexmk -pdf -pvc main.tex
        " will allow automatic compilation on write.
        setl makeprg=latexmk\ -pdf\ %
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

function! Preserve(command)
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    execute a:command

    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! DeleteTrailingWhitespace()
    call Preserve("%s/\\s\\+$//e")
endfunction

function! CloseWindowOrKillBuffer()
    let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

    if number_of_windows_to_this_buffer > 1
        wincmd c
    else
        bdelete
    endif
endfunction

function! RemoveBackground()
    if !s:is_gui
        "Remove background set by colorscheme
        hi Normal ctermbg=NONE
        hi Comment ctermbg=NONE
        hi Constant ctermbg=NONE
        hi Special ctermbg=NONE
        hi Identifier ctermbg=NONE
        hi Statement ctermbg=NONE
        hi PreProc ctermbg=NONE
        hi Type ctermbg=NONE
        hi Underlined ctermbg=NONE
        hi Todo ctermbg=NONE
        hi String ctermbg=NONE
        hi Function ctermbg=NONE
        hi Conditional ctermbg=NONE
        hi Repeat ctermbg=NONE
        hi Operator ctermbg=NONE
        hi Structure ctermbg=NONE
    endif
endfunction

"===============================================================================
" => Autocommands
"===============================================================================
if has('autocmd')
    " Reset autogroup
    augroup MyAutoCmd
        autocmd!
    augroup END

    " " Cursorline can sometimes be super slow, especially with a ton of
    " " syntax highlighting
    " augroup MyAutoCmd
    "     " Turn on cursorline only on active window
    "     autocmd WinLeave * setlocal nocursorline
    "     autocmd WinEnter,BufRead * setlocal cursorline
    " augroup END

    augroup MyAutoCmd
        " Resize splits when window is resized
        autocmd VimResized * exe "normal! \<c-w>="

        " Html settings
        autocmd FileType html setlocal shiftwidth=2 tabstop=2
    augroup END

    " Move quickfix to the bottom always
    augroup MyAutoCmd
        autocmd FileType qf wincmd J
    augroup END

    " " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    " autocmd BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
    " autocmd InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

    augroup MyAutoCmd
        if !s:is_gui
            autocmd ColorScheme * call RemoveBackground()
        endif
    augroup END
endif

"===============================================================================
" => General
"===============================================================================

" Sets how many lines of history VIM has to remember
set history=1000

" Enable filetype plugin
filetype plugin on
filetype indent on

" set encoding=utf-8

" Allow changing buffer without saving first
set hidden

" Allow Mouse Usage
set mouse=a

" Hide mouse when typing
set mousehide

" Make with n cores
set makeprg=make\ -j\ -k

if has ('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

set ttyfast
"set ttyscroll=0
set ttimeout
set ttimeoutlen=50

" Auto reload if file is saved externally.
set autoread
set autowrite

" Turn off cursor blinking
set guicursor=a:blinkon0

set foldcolumn=1

"===============================================================================
" => VIM user interface
"===============================================================================
set shortmess=Iat

" Blank vsplit separator
set fillchars+=vert:\ 

" Ask for confirmation for various things
set confirm

" Don't complete from other buffer
set complete=.

" Set 3 lines to pad the cursor - when moving vertical..
set scrolloff=10
set sidescrolloff=5

" Auto complete setting
set completeopt=longest,menuone

" show list for autocomplete
set wildmenu
set wildmode=list:longest
set wildignorecase

set wildignore=*.o,*.pyc,*.hi
set wildignore+=.hg,.git,.svn,.gitignore         " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.dll,*.manifest       " compiled object files
set wildignore+=*.d                              " dependency files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX BS

set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code

set wildignore+=*.wav,*.mp3,*.ogg
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*.pdf

set wildignore+=*.exe,*.jar,*.class

" Files with these suffixes get a lower priority when matching a wildcard
set suffixes=.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

set ruler "Always show current position

" Line Numbers
" set number

" Allow backspacing everything in insert mode
set backspace=indent,eol,start

" Searching
set ignorecase " Ignore case when searching
set smartcase  " If there are any capitalized letters, case sensitive search

set nohlsearch " Don't Highlight search things
set incsearch  " Make search act like search in modern browsers
set wrapscan   " Search wraps around the end of the file


if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
    set grepformat=%f:%l:%c:%m
endif

if has('conceal')
    set conceallevel=2
    set concealcursor=i
    set listchars+=conceal:Δ
endif

set gdefault "substitute default = all matches on line

set showmatch " Show matching bracets when text indicator is over them
set matchtime=2

set virtualedit=onemore

set nomodeline
set modelines=0

" Disable all bells
set noerrorbells
set novisualbell
set t_vb=

set lazyredraw

"===============================================================================
" => Files and backups
"===============================================================================
" Do not store global/local values in a session.
set ssop-=options
set ssop-=folds

if has('persistent_undo')
    set undodir=~/.vim/cache/undo/
    "set undofile
    set undolevels=1000
    if exists('+undoreload')
        set undoreload=1000
    endif
endif

" Backups
set backupdir=~/.vim/cache/backup/
set nowritebackup
set nobackup

" Swap Files
set directory=~/.vim/cache/swap/
set noswapfile

function! EnsureExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path))
    endif
endfunction
call EnsureExists('~/.vim/cache')
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)

"===============================================================================
" => Text, tab and indent related
"===============================================================================
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set copyindent

set autoindent
set smartindent
" set cindent

set cinoptions+=(0

set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,trail:• ",eol:¬
set showbreak=↪

set wrap
set whichwrap+=h,l,<,>,[,]
set linebreak
" set tw=500

set formatoptions=ql


"===============================================================================
" => Moving around, tabs and buffers
"===============================================================================
set splitright
set splitbelow

" Multiple buffer stuff
"set switchbuf=useopen
set switchbuf=usetab

" Easy buffer navigation
" nmap <silent> <C-h> :wincmd h<CR>
" nmap <silent> <C-j> :wincmd j<CR>
" nmap <silent> <C-k> :wincmd k<CR>
" nmap <silent> <C-l> :wincmd l<CR>

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

" Bracket matching made easy?
"nnoremap <tab> %
"vnoremap <tab> %

" Tab Switching (non-terminal vim only)
" nmap <C-S-tab> :tabp<CR>
" nmap <C-tab>   :tabn<CR>

" Q will kill buffer if only window with buffer open, otherwise just close the window
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>

"===============================================================================
" => Other Key Remapping
"===============================================================================
" Mapleader and localleader.
let mapleader = " "
let maplocalleader = " "

" Fix broken vim regexes when searching
" nnoremap / /\v
" vnoremap / /\v
" nnoremap ? ?\v
" vnoremap ? ?\v
" cnoremap s/ s/\v
set magic

" Make Y consistent with C and D. See :help Y.
nnoremap Y y$

" Sudo to write
" cmap W!! w !sudo tee % >/dev/null

" Avoid Typos
" silent! command -nargs=0 W w
" silent! command -nargs=0 Q q
" silent! command -nargs=0 WQ x
" silent! command -nargs=0 Wq x

"===============================================================================
" => Insert Mode Key Remapping
"===============================================================================
" map control-backspace to delete the previous word
" imap <C-BS> <C-W>

" Escape is far...
" imap jk <ESC>
" imap kj <ESC>

"===============================================================================
" => Colors and Fonts
"===============================================================================
syntax enable

" if !s:is_gui
"     set t_Co=256

"     " set background=dark
"     " colorscheme hemisu
"     colorscheme default

"     " let g:seoul256_background = 233
"     " colorscheme seoul256
" else
"     set background=dark
"     colorscheme hemisu

"     " let g:seoul256_background = 233
"     " colorscheme seoul256
" endif

colorscheme apprentice
highlight FoldColumn ctermbg=NONE

" Set font
if s:is_windows
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
let &statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$')"
            \ . ".(winnr('#')==winnr()?'#':'').']':''}\ "
            \ . "%{(&previewwindow?'[preview] ':'').expand('%:t:.')}"
            \ . "\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
            \ . "%{printf('  %4d/%d',line('.'),line('$'))}"

" let g:airline_left_sep=''
" let g:airline_right_sep=''
" let g:airline_detect_modified=1
" let g:airline_detect_iminsert=1
" let g:airline_theme="wombat"

" let g:airline#extensions#bufferline#enabled = 0

" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_close_button = 0
" let g:airline#extensions#tabline#show_buffers = 0
" let g:airline#extensions#tabline#tab_nr_type = 0 " # of splits (default)

" let g:airline#extensions#branch#enabled = 0
" let g:airline#extensions#syntastic#enabled = 0
" let g:airline#extensions#whitespace#enabled = 0

" Always show the statusline
set laststatus=2

" Show incomplete commands
set showcmd

" No need to show mode due to statusline modifications
set noshowmode

"===============================================================================
" => Plugin Settings
"===============================================================================
" nnoremap <silent> <leader>e :<C-u>so %<CR>

" nmap <F1> <leader>h
nmap <F2> :<C-u>VimFiler<CR>

map <F5>  :<C-u>call CompileAndRun(0)<CR>
map <F6>  :<C-u>call CompileAndRun(1)<CR>
map <F7>  :<C-u>call Premake()<CR>

" Open terminal in current directory
nnoremap <silent> <leader>t :<C-u>!eval $TERMINAL<CR><CR>

" Change cwd to current buffer directory
nnoremap          <leader>c :<C-u>cd %:p:h<CR>

command! DeleteTrailingWhitespace call DeleteTrailingWhitespace()

" map <F7> :!ctags --verbose=yes -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Sneak case sensitivity is determined by 'ignorecase' and 'smartcase'.
let g:sneak#use_ic_scs = 1

" fzf
nnoremap <silent> <leader>z :<C-u>FZF -m<CR>

"===============================================================================
" => Auto-complete
"===============================================================================

" " YouCompleteMe
" "
" let g:EclimCompletionMethod = 'omnifunc'
" let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
" let g:ycm_confirm_extra_conf = 0
" let g:ycm_filetype_blacklist = {
"             \ 'notes' : 1,
"             \ 'markdown' : 1,
"             \ 'text' : 1,
"             \ 'unite' : 1
"             \}
" 
" let g:ycm_show_diagnostics_ui = 1
" let g:ycm_enable_diagnostic_highlighting = 1

" Deoplete
let g:deoplete#enable_at_startup = 1

"===============================================================================
" => NeoSnippet
"===============================================================================

" " Plugin key-mappings.
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

" " SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"             \ "\<Plug>(neosnippet_expand_or_jump)"
"             \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"             \ "\<Plug>(neosnippet_expand_or_jump)"
"             \: "\<TAB>"

"===============================================================================
" => Unite
"===============================================================================

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])

" Set up some custom ignores
call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep',
            \ 'ignore_pattern', join([
            \ '\.git/',
            \ 'git5/.*/review/',
            \ 'google/obj/',
            \ ], '\|'))

call unite#custom#profile('default', 'context', {
      \ 'winheight'      : 12,
      \ 'direction'      : 'botright',
      \ 'start_insert'   : 1,
      \ 'update_time'    : 200,
      \ 'prompt'         : '» ',
      \ 'marked_icon'    : '✓',
      \ 'max_candidates' : 5000
      \ })

" General fuzzy search
" nnoremap <silent> <leader><space> :<C-u>Unite
"       \ -buffer-name=files buffer file_mru bookmark file<CR>

" Quick registers
nnoremap <silent> <leader>r :<C-u>Unite -buffer-name=register register<CR>

" Quick buffer
nnoremap <silent> <leader>u :<C-u>Unite -buffer-name=buffers buffer<CR>

" Quick yank history
nnoremap <silent> <leader>y :<C-u>Unite -buffer-name=yanks history/yank<CR>

" Quick outline
" nnoremap <silent> <leader>o :<C-u>Unite -buffer-name=outline -vertical outline<CR>

" Quick sessions (projects)
" nnoremap <silent> <leader>p :<C-u>Unite -buffer-name=sessions session<CR>

" Quick sources
nnoremap <silent> <leader>a :<C-u>Unite -buffer-name=sources source<CR>

" Quick snippet
" nnoremap <silent> <leader>s :<C-u>Unite -buffer-name=snippets snippet<CR>

" Quickly switch lcd
nnoremap <silent> <leader>d :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory<CR>
nnoremap <silent> <leader>D
            \ :<C-u>UniteWithCurrentDir -buffer-name=change-cwd -default-action=lcd directory<CR>
nnoremap <silent> <leader><C-d>
            \ :<C-u>UniteWithBufferDir -buffer-name=change-cwd -default-action=lcd directory<CR>

" Quick file search
nnoremap <silent> <leader>f :<C-u>Unite -buffer-name=files file file/new<CR>
nnoremap <silent> <leader>F :<C-u>UniteWithCurrentDir -buffer-name=files file file/new<CR>
nnoremap <silent> <leader><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>

" Quick Recursive File Search
if s:is_windows
    nnoremap <silent> <leader>p :<C-u>Unite -buffer-name=files file_rec<CR>
else
    nnoremap <silent> <leader>p :<C-u>Unite -buffer-name=files file_rec/async<CR>
endif

" Quick grep from cwd
nnoremap <silent> <leader>g :<C-u>Unite -buffer-name=grep grep:.<CR>

" Quick help
" nnoremap <silent> <leader>h :<C-u>Unite -buffer-name=help help<CR>

" Quick line using the word under cursor
nnoremap <silent> <leader>l :<C-u>Unite -buffer-name=search_file line<CR>

" Quick MRU search
" nnoremap <silent> <leader>m :<C-u>Unite -buffer-name=mru file_mru<CR>

" Quick find
nnoremap <silent> <leader>n :<C-u>Unite -buffer-name=find find:.<CR>

" Quick commands
nnoremap <silent> <leader>x :<C-u>Unite -buffer-name=commands command<CR>
nnoremap <silent> <M-x> :<C-u>Unite -buffer-name=commands command<CR>

" Unicode insert
nnoremap <silent> <leader>i :<C-u>Unite -buffer-name=unicode unicode<CR>

" Unite Neobundle update
" nnoremap <silent> <leader>z :<C-u>Unite neobundle/update -log -wrap -vertical -auto-quit<CR>

" Quick bookmarks
" nnoremap <silent> <leader>b :<C-u>Unite -buffer-name=bookmarks bookmark<CR>

" Fuzzy search from current buffer
" nnoremap <silent> <leader>b :<C-u>UniteWithBufferDir
" \ -buffer-name=files -prompt=%\ buffer file_mru bookmark file<CR>

" Quick commands
" nnoremap <silent> <leader>; :<C-u>Unite -buffer-name=history history/command command<CR>

" Custom Unite settings
autocmd MyAutoCmd FileType unite call s:unite_settings()
function! s:unite_settings()
    nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> <ESC> <Plug>(unite_exit)

    nmap <buffer> <nowait> <C-g> <Plug>(unite_exit)
    imap <buffer> <nowait> <C-g> <Plug>(unite_exit)

    imap <buffer> jj <Plug>(unite_insert_leave)
    imap <buffer> <C-j> <Plug>(unite_insert_leave)

    nmap <buffer> <C-j> <Plug>(unite_loop_cursor_down)
    nmap <buffer> <C-k> <Plug>(unite_loop_cursor_up)
    imap <buffer> <TAB> <Plug>(unite_select_next_line)

    imap <buffer> <C-a> <Plug>(unite_choose_action)

    imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
    imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
    " imap <buffer> <BS>  <Plug>(unite_delete_backward_path)

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

" Enable history yank source
let g:unite_source_history_yank_enable = 1

" Data directory location
let g:unite_data_directory = expand('~/.vim/cache/unite')

" Use ack/ag for search
if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C4'
    let g:unite_source_grep_recursive_opt=''

    " Set up ignores for ag when using file_rec/async
    let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore ".hg" --ignore ".svn" --ignore ".git" --ignore ".bzr" --hidden -g ""'
elseif executable('ack')
    let g:unite_source_grep_command='ack'
    let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
    let g:unite_source_grep_recursive_opt=''
endif

" "===============================================================================
" " => VimFiler
" "===============================================================================

" let g:vimfiler_as_default_explorer = 1
" let g:vimfiler_data_directory = expand('~/.vim/cache/vimfiler')

" " Icons
" let g:vimfiler_tree_leaf_icon = ' '
" let g:vimfiler_tree_opened_icon = '▾'
" let g:vimfiler_tree_closed_icon = '▸'
" let g:vimfiler_file_icon = ' '
" let g:vimfiler_marked_file_icon = '✓'
" let g:vimfiler_readonly_file_icon = '✗'

" "===============================================================================
" " => FZF
" "===============================================================================

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" " In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }

" " Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.fzf-history'
