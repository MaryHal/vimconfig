"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible               " Be iMproved

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My bundles
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
"NeoBundle 'Shougo/unite-help'
"NeoBundle 'Shougo/unite-session'

" Code Completion
NeoBundle 'Shougo/neocomplcache'

" Snippets
NeoBundle 'Shougo/neosnippet'

" Buffers, Tabs, and such
NeoBundle 'a.vim'
NeoBundle 'bufkill.vim'
NeoBundle 'scrooloose/nerdtree'

" Usability
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Lokaltog/vim-easymotion'

" Color Scheme plugins and appearance
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'Lokaltog/vim-powerline'

" Filetype plugins
NeoBundle 'jceb/vim-orgmode'

filetype plugin indent on " required! 

NeoBundleCheck            " Installation check.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Allow Mouse Usage
set mouse=a

"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/glfw

" Let's use ack instead of grep!
set grepprg=ack

" Make with 2 cores
" set makeprg=make\ -j2

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

"set ofu=syntaxcomplete#Complete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No intro splash
set shortmess=I

" Ask for confirmation for various things
set confirm
set completeopt=menu,menuone,longest

" Set 3 lines to pad the cursor - when moving vertical..
set scrolloff=3
set sidescrolloff=5

set wildmenu " Turn on WiLd menu
set wildmode=longest:full,full
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

set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code

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

set gdefault "substitute default = all matches on line

set showmatch "Show matching bracets when text indicator is over them
set matchtime=5

set modelines=0

" Disable all bells
set noerrorbells visualbell t_vb=

set lazyredraw

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowritebackup
set nobackup
set noswapfile

if has('persistent_undo')
    set undodir=~/.vim/tmp/undo/     " undo files
    set undofile
    set undolevels=1000
    if exists('+undoreload')
        set undoreload=1000
    endif
endif
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files
set backup                       " enable backups
set undofile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set autoindent
"set smartindent
set cindent

set list
"set listchars=extends:»,precedes:«,tab:▸\ ,trail:°
"set listchars=tab:▸\ ,extends:»,precedes:«
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
"set showbreak=↪

set wrap
set linebreak
" set tw=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright
set splitbelow

" Multiple buffer stuff
"set switchbuf=useopen
set switchbuf=usetab

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Easy buffer navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
noremap <leader>v <C-w>v

" Fast Tab Switching?
nmap <silent> J gT
nmap <silent> K gt

" line wrap movement
noremap j gj
noremap k gk

" map control-backspace to delete the previous word
" imap <C-BS> <C-W>

"map H ^
"map L g_

"nmap <silent> <C-S-w> :wincmd<Space>

" Escape is far...
"imap jk <ESC>
"imap kj <ESC>

"imap jj <Esc>
"inoremap <A-Space> <Esc>

" Bracket matching made easy?
"nnoremap <tab> %
"vnoremap <tab> % 

" Tab Switching (non-terminal vim only)
"nmap <C-S-tab> :tabp<CR>
"nmap <C-tab>   :tabn<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other Key Remapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix broken vim regexes when searching
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s/ s/\v

" Make Y consistent with C and D. See :help Y.
nnoremap Y y$

" Less chording
"nnoremap ; :

" Sudo to write
"cmap W!! w !sudo tee % >/dev/null

" Avoid Typos
silent! command -nargs=0 W w
silent! command -nargs=0 Q q
silent! command -nargs=0 WQ x
silent! command -nargs=0 Wq x

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('autocmd')
    " Resize splits when window is resized
    au VimResized * exe "normal! \<c-w>="

    augroup closenerdtreeiflastwindow
        au!
        au BufEnter *
                    \ if exists("t:NERDTreeBufName")            |
                    \   if bufwinnr(t:NERDTreeBufName) != -1    |
                    \       if winnr("$") == 1                  |
                    \           q                               |
                    \       endif                               |
                    \   endif                                   |
                    \ endif
    augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

"if has("gui_running")
"    colorscheme fu
"elseif &t_Co != 256
"    colorscheme asdf
"else
"    colorscheme fu
"
"    " fu modifications
"    hi NonText        ctermfg=248   ctermbg=none  cterm=bold     guifg=#a8a8a8  guibg=#121212
"    hi Normal         ctermfg=252   ctermbg=none                 guifg=#d0d0d0  guibg=#1c1c1c
"    hi Visual         ctermfg=none  ctermbg=238   cterm=bold
"    hi StatusLineNC   ctermfg=234   ctermbg=253                  guifg=#3a3a3a  guibg=#dadada
"endif

let g:hybrid_use_Xresources = 1
colorscheme hybrid

" Set font
if has("win32") || has('win64')
    set guifont=Consolas:h8:cANSI
    cd ~
else
    set guifont=Inconsolata\ 10
endif

set guioptions=acg
set ffs=unix,dos,mac "Default file types

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the statusline
set laststatus=2

hi StatColor guibg=#94e454 guifg=black ctermbg=lightgreen ctermfg=black
hi Modified guibg=orange guifg=black ctermbg=lightred ctermfg=black

let &guicursor = &guicursor . ",a:blinkon0"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :call CompileAndRun(0)<CR>
map <F6> :call CompileAndRun(1)<CR>

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
        setl makeprg=make\ -j \ -k
    elseif filereadable("build.xml")
        setl makeprg=ant
    elseif &filetype == 'c'
        setl makeprg=gcc\ -Wall\ -std=c99\ -o\ %<\ %
    elseif &filetype == 'cpp'
        setl makeprg=g++\ -Wall\ -o\ %<\ %
    elseif &filetype == 'java'
        setl makeprg=javac\ %
        let l:progname = 'java ' . expand('%:t:r')
        let l:interpreter = 1
    elseif &filetype == 'matlab'
        let l:progname = 'octave ' . expand('%') . ' | less'
        let l:interpreter = 1
        let l:domake = 0
    elseif &filetype == 'tex'
        let l:progname = 'pdflatex ' . expand('%:p')
        let l:domake = 0
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:Powerline_symbols = 'fancy'
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

let NerdTreeQuitOnExit=1

nnoremap <silent> <F1> <ESC>:NERDTreeToggle<CR>

command! -nargs=? -bar F FufFile
nnoremap <C-p> <ESC>:FufFileWithCurrentBufferDir<CR>
nnoremap <C-o> <ESC>:FufBuffer<CR>

let g:EasyMotion_leader_key = '<Leader>'

map <F7> :!ctags --verbose=yes -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"===============================================================================
" Autocommands
"===============================================================================

" Turn on cursorline only on active window
augroup MyAutoCmd
  autocmd WinLeave * setlocal nocursorline
  autocmd WinEnter,BufRead * setlocal cursorline
augroup END

" q quits in certain page types. Don't map esc, that interferes with mouse input
autocmd MyAutoCmd FileType help,quickrun
      \ if (!&modifiable || &ft==#'quickrun') |
      \ nnoremap <silent> <buffer> q :q<cr>|
      \ nnoremap <silent> <buffer> <esc><esc> :q<cr>|
      \ endif
autocmd MyAutoCmd FileType qf nnoremap <silent> <buffer> q :q<CR>

" json = javascript syntax highlight
autocmd MyAutoCmd FileType json setlocal syntax=javascript

" Enable omni completion
augroup MyAutoCmd
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType java setlocal omnifunc=eclim#java#complete#CodeComplete
augroup END


"===============================================================================
" Neocomplcache and Neosnippets
"===============================================================================

" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 4
let g:neocomplcache_min_keyword_length = 4
" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1
let g:snips_author = ""
let g:neocomplcache_max_list=10
" <Tab>'s function is overloaded depending on the context:
" - If the current word is a snippet, then expand that snippet
" - If we're in the middle of a snippet, tab jumps to the next placeholder text
" - If the competion menu is visible, enter the currently selected entry and
" close the popup
" - If none of the above is true, simply do what <Tab> does originally
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? neocomplcache#close_popup() : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Enter always performs a literal enter
imap <expr><cr> neocomplcache#smart_close_popup() . "\<CR>"

" if has('conceal')
" set conceallevel=2 concealcursor=i
" endif

" Tell Neosnippets to use the snipmate snippets
let g:neosnippet#snippets_directory='~/.dotfiles/.vim/bundle/snipmate-snippets,~/.dotfiles/.vim/snippets'

" These are the battle scars of me trying to get omni_patterns to work correctly
" so Neocomplcache and Eclim could co-exist peacefully. No cigar.
" if !exists('g:neocomplcache_force_omni_patterns')
" let g:neocomplcache_force_omni_patterns = {}
" endif
" if !exists('g:neocomplcache_omni_patterns')
" let g:neocomplcache_omni_patterns = {}
" endif
" let g:neocomplcache_force_omni_patterns.java = '\%(\.\)\h\w*'
" let g:neocomplcache_force_omni_patterns.java = '.'
" let g:neocomplcache_omni_patterns.java = '\%(\.\)\h\w*'

" Ok this requires some explanation. I couldn't get Neocomplcache and Eclim to
" play nice with each other. When Neocomplcache triggers omni_complete under
" Eclim, everything just blows up. I tried to configure omni_patterns using
" Neocomplcache, but nothing I tried worked. What eventually worked is disabling
" omni_complete from the Neocomplcache sources for java files, and trigger it
" manually with Ctrl-Space. Neocomplcache also has this strange behavior where
" it overrides the completeopt flag to always remove 'longest'. In order for
" Ctrl-Space to trigger sane behavior of autocomplete and not always select the
" first entry by default, I need to temporarily set completeopt to include
" longest when the key is triggered. Theoratically I could call
" neocomplcache#start_manual_complete, but I think that requires the
" omni_patterns to set correctly and I couldn't get that to work
function! s:disable_neocomplcache_for_java()
  if &ft ==# 'java'
    :NeoComplCacheLockSource omni_complete
    inoremap <buffer> <c-@> <C-R>=<SID>java_omni_complete()<CR>
  endif
endfunction

function! s:java_omni_complete()
  setlocal completeopt+=longest
  return "\<C-X>\<C-O>"
endfunction

" autocmd MyAutoCmd BufEnter * call s:disable_neocomplcache_for_java()

"===============================================================================
" Unite
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
      \ -buffer-name=files buffer file_mru bookmark file_rec/async<CR>

" Quick registers
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" Quick buffer and mru
nnoremap <silent> [unite]u :<C-u>Unite -buffer-name=buffers buffer file_mru<CR>

" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>

" Quick outline
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline -vertical outline<CR>

" Quick sessions (projects)
nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions session<CR>

" Quick sources
nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources source<CR>

" Quick snippet
nnoremap <silent> [unite]s :<C-u>Unite -buffer-name=snippets snippet<CR>

" Quickly switch lcd
nnoremap <silent> [unite]d
      \ :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory_mru<CR>

" Quick file search
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async file/new<CR>

" Quick grep from cwd
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=grep grep:.<CR>

" Quick help
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>

" Quick line using the word under cursor
nnoremap <silent> [unite]l :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>

" Quick MRU search
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>

" Quick find
nnoremap <silent> [unite]n :<C-u>Unite -buffer-name=find find:.<CR>

" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>

" Quick bookmarks
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=bookmarks bookmark<CR>

" Fuzzy search from current buffer
" nnoremap <silent> [unite]b :<C-u>UniteWithBufferDir
" \ -buffer-name=files -prompt=%\ buffer file_mru bookmark file<CR>

" Quick commands
nnoremap <silent> [unite]; :<C-u>Unite -buffer-name=history history/command command<CR>

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
  inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
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

" Shorten the default update date of 500ms
let g:unite_update_time = 200

let g:unite_source_file_mru_limit = 1000
let g:unite_cursor_line_highlight = 'TabLineSel'
" let g:unite_abbr_highlight = 'TabLine'

let g:unite_source_file_mru_filename_format = ':~:.'
let g:unite_source_file_mru_time_format = ''

" For ack.
if executable('ack-grep')
  let g:unite_source_grep_command = 'ack-grep'
" Match whole word only. This might/might not be a good idea
  let g:unite_source_grep_default_opts = '--no-heading --no-color -a -w'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ack')
  let g:unite_source_grep_command = 'ack'
  let g:unite_source_grep_default_opts = '--no-heading --no-color -a -w'
  let g:unite_source_grep_recursive_opt = ''
endif

