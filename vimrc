" ====================
" => Pre-init
" ====================
let s:is_cygwin = has('win32unix') || has('win64unix')
let s:is_windows = has('win32') || has('win64')
let s:is_mac = has('gui_macvim') || has('mac')
let s:is_msysgit = (has('win32') || has('win64')) && $TERM ==? 'cygwin'
let s:is_tmux = !empty($TMUX)
let s:is_ssh = !empty($SSH_TTY)

if s:is_windows && !s:is_cygwin && !s:is_msysgit
    let s:dotvim=expand("~/vimfiles/")
else
    let s:dotvim=expand("~/.vim/")
endif

let s:is_gui = has('gui_running') || strlen(&term) == 0 || &term ==? 'builtin_gui'

" ====================
" => Files and Backups
" ====================
set sessionoptions-=options
set sessionoptions-=folds

if has('persistent_undo')
    execute "set undodir=" . s:dotvim . '/cache/undo/'
    set undofile
    set undolevels=1000
    if exists('+undoreload')
        set undoreload=1000
    endif
endif

" Backups
execute "set backupdir=" . s:dotvim . '/cache/backup/'
" set nowritebackup
" set nobackup

" Swap Files
execute "set directory=" . s:dotvim . '/cache/swap/'
" set noswapfile

function! EnsureExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path))
    endif
endfunction
call EnsureExists(s:dotvim . '/cache')
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)

" ====================
" => Plugins
" ====================
call plug#begin(s:dotvim . 'plugged')

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'Shougo/denite.nvim'

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'

Plug 'MaryHal/Apprentice'
Plug 'MaryHal/vim-colors-plain'

Plug 'editorconfig/editorconfig-vim'

Plug 'junegunn/vim-peekaboo'

Plug 'lambdalisue/gina.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'

Plug 'wellle/targets.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'romainl/vim-qf'
Plug 'tpope/vim-unimpaired'

Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'tweekmonster/django-plus.vim'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'w0rp/ale'

" Initialize plugin system
call plug#end()

" ====================
" => General
" ====================
set encoding=utf-8

set hidden

" Allow Mouse Usage
set mouse=a
set mousehide

set autoread
set autowrite

set foldcolumn=1

" ====================
" => User Interface
" ====================
set shortmess=Iatc

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
set completeopt=menuone,noselect,preview

" show list for autocomplete
set wildmenu
set wildmode=list:longest
set wildignorecase

" Always show current position
set ruler 

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
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
    set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
    set grepformat=%f:%l:%c:%m
endif

set showmatch
set matchtime=2

" set virtualedit=onemore

set nomodeline
set modelines=0

set lazyredraw

" ====================
" => Formatting
" ====================
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

set autoindent

" set list
" set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,trail:• ",eol:¬
" set showbreak=↪

" set wrap
set whichwrap+=h,l,<,>,[,]
set linebreak

set formatoptions=ql

" ====================
" => Functions
" ====================
function! RemoveBackground() abort
    if !s:is_gui
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

" ====================
" => Autocommands
" ====================
if has('autocmd')
    " Reset autogroup
    augroup MyAutoCmd
        autocmd!
    augroup END

    augroup MyAutoCmd
        if !s:is_gui
            autocmd ColorScheme * call RemoveBackground()
        endif
    augroup END

    autocmd BufLeave * let b:winview = winsaveview()
    autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif

    autocmd BufNewFile,BufRead *.tera set filetype=htmldjango
endif

" ====================
" => Windows and Moving around
" ====================
set splitright
set splitbelow

set switchbuf=usetab

nnoremap <silent> <leader>k :<C-u>bw<CR>

nmap K kJ

set equalalways

" line wrap movement
noremap j gj
noremap k gk

" Reselect visual block after indent
xnoremap < <gv
xnoremap > >gv

nmap <C-S-tab> :tabp<CR>
nmap <C-tab>   :tabn<CR>

function! ExecuteMacroOverVisualRange() abort
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" ====================
" => Other Keys
" ====================
let mapleader = "\<Space>"

" " Fix broken vim regexes when searching
" " nnoremap / /\v
" " vnoremap / /\v
" " nnoremap ? ?\v
" " vnoremap ? ?\v
" " cnoremap s/ s/\v
" set magic

nnoremap Y yg_
 
cmap W!! w !sudo tee % >/dev/null
 
silent! command -nargs=0 W w
silent! command -nargs=0 Q q
silent! command -nargs=0 WQ x
silent! command -nargs=0 Wq x
 
imap <C-BS> <C-W>

" ====================
" => User Interface
" ====================
syntax enable

set background=light
colorscheme plain

if s:is_gui 
    set lines=40 columns=120
endif
 

if s:is_windows && !s:is_cygwin && !s:is_msysgit
    set guifont=Iosevka_Term_Slab:h9
else
    set guifont=Iosevka\ Term\ Slab\ 9
endif
 
set guioptions=acg

" ====================
" => Statusline
" ====================
function! CustomStatusLine()
    " let &statusline=" %{winnr('$')>1?'['.winnr().'/'.winnr('$')"
    "             \ . ".(winnr('#')==winnr()?'#':'').']':''}\ "
    "             \ . "%{(&previewwindow?'[preview] ':'').expand('%:t:.')} "
    "             \ . "\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
    "             \ . "%{printf('  %4d/%d',line('.'),line('$'))}\ "
    if has('statusline')
        function! ALEWarnings() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '' : printf('  W:%d ', all_non_errors)
        endfunction

        function! ALEErrors() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '' : printf(' E:%d ', all_errors)
        endfunction

        function! ALEStatus() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? ' ok ' : ''
        endfunction

        set statusline=\ %<%f
        set statusline+=%w%h%m%r

        set statusline+=\ %y
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%\ 

        set statusline+=\%#StatusLineOk#%{ALEStatus()}
        set statusline+=\%#StatusLineError#%{ALEErrors()}
        set statusline+=\%#StatusLineWarning#%{ALEWarnings()}
    endif
endfunction

exec CustomStatusLine()

" Always show the statusline
set laststatus=2

" Show incomplete commands
set showcmd

" ====================
" => Plugin Settings
" ====================
nnoremap <silent> <leader>eb :<C-u>so %<CR>
vnoremap <silent> <leader>er :<C-u>@*<CR>

" Change cwd to current buffer directory
nnoremap          <leader>c :<C-u>cd %:p:h<CR>
nnoremap          <leader>g :<C-u>Gstatus<CR>

command! -nargs=0 Jq :%!jq "."

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif 

let g:targets_argOpening = '[({[]'
let g:targets_argClosing = '[]})]'

" ====================
" => Auto-Complete
" ====================

" ====================
" => FZF
" ====================
" if s:is_windows && !s:is_cygwin && !s:is_msysgit
"     let $TERM = ''
" endif

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
 
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
 
" In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '15split enew' }
 
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'hl':      ['fg', 'String'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'hl+':     ['fg', 'String'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
 
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
"
let g:fzf_history_dir = s:dotvim . '/cache/fzf_history'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

nnoremap <silent> <leader>u :<C-u>Buffers<CR>
nnoremap <silent> <leader>f :<C-u>Files<CR>
nnoremap <silent> <leader>p :<C-u>GFiles<CR>
nnoremap <silent> <leader>l :<C-u>BLines<CR>
nnoremap <silent> <leader>x :<C-u>Commands<CR>
nnoremap <silent> <M-x>     :<C-u>Commands<CR>

