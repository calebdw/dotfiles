"" START Vim-Plug PLUGIN MANAGER ""

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


set nocompatible


" Required:
call plug#begin()

Plug 'tpope/vim-abolish'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-commentary'
Plug 'drmikehenry/vim-fontsize'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-swap'
Plug 'triglav/vim-visual-increment'
Plug 'tpope/vim-unimpaired'
Plug 'lervag/vimtex'

" Required:
call plug#end()

" Required:
filetype plugin indent on

" Load python faster in nvim
let g:python3_host_prog = '/usr/bin/python3'

" Make command line two lines high
set cmdheight=2

" Hide the mouse when typing text
set mousehide


"" VIMTEX OPTIONS ""
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
"let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '.build',
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

"" YCM TIGGERS ""
" Triggers for vimtex
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

if has('gui_running')
    set guifont=Monospace\ 12
    autocmd GUIEnter * call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)
    set toolbariconsize=giant
endif

" Commands specific to vim
" (many are defaults in nvim)
if !has('nvim')
    set autoindent
    set backspace=indent,eol,start
    set belloff=all
    set encoding=utf-8
    set ttymouse=xterm2
    set wildmenu
endif

set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set spell
colorscheme lyla
set wildmode=longest,list
set ignorecase
set smartcase
set lazyredraw

" Split behaviour
set splitbelow
set splitright

set undofile
set undodir=$HOME/.vim/undo/
set directory=$HOME/.vim/swap/
set backupdir=$HOME/.vim/backup/

" Automatically change to file directory
" set autochdir

"" REMAPS ""

" Lazy escape
imap jk <ESC>
imap kj <ESC>

" Map Y to act like D/C
map Y y$


" Status line
set laststatus=2
set statusline=
"set statusline=%{FugitiveStatusline()}
set statusline+=%#PmenuSel#
set statusline+=%#LineNr#
set statusline+=\ %F
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %l:%c
set statusline+=\ %p%%
set statusline+=\



" Enable clipboard support


" Make shift-insert insert clipboard
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>


