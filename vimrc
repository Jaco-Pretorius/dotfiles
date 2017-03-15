" use vim not vi
set nocompatible

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" git helpers, mostly useful for :GBlame
Bundle 'tpope/vim-fugitive'

" shows git changes to the left of line numbers
Bundle 'airblade/vim-gitgutter'

" fuzzy search across all files in directory
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'JazzCore/ctrlp-cmatcher', { 'do': 'CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments ./install.sh' }

" smart search within all files
Bundle 'mileszs/ack.vim'

" typing autocomplete using lua
Bundle 'Shougo/neocomplete.vim'

" tree-explorer view on demand
Bundle 'scrooloose/nerdtree'

" powerful commenting
Bundle 'scrooloose/nerdcommenter'

" Syntax
Bundle 'tpope/vim-endwise'
Bundle 'pangloss/vim-javascript'
Bundle 'elzr/vim-json'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'tpope/vim-markdown'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'editorconfig/editorconfig-vim'

" Colorschemes
Bundle 'junegunn/seoul256.vim'
Bundle 'tomasr/molokai'

call vundle#end()

" Appearance
" ----------
syntax on
syntax enable
if !has('gui_running')
  set t_Co=256
endif
set noshowmode
set background=dark
set guifont=Hack:h16
colorscheme molokai

" General Config
" --------------
let mapleader = ","
set number                         " show line numbers
set backspace=indent,eol,start     " let backspace work over anything
set showcmd                        " show typed command prefixes while waiting for operator
set autoread                       " no prompt for file changes outside vim
set laststatus=2                   " always show statusline
set hidden                         " allow hidden, unsaved buffers
set splitright                     " add new windows towards the right
set splitbelow                     " add new windows towards the bottom
set ttyfast                        " optimize for fast terminal connections
set noerrorbells                   " disable error bells
set visualbell t_vb=               " disable visual bells
set shortmess=atIA                 " don’t show the intro message or "ATTENTION" warnings
set clipboard=unnamed              " use the OS clipboard by default (on versions compiled with `+clipboard`)
set swapfile                       " Keep swapfiles
set directory=~/.vim-tmp,~/tmp,/var/tmp,/tmp
set backupdir=~/.vim-tmp,~/tmp,/var/tmp,/tmp


" Mouse Config
" ------------
set mouse=a                        " enable mouse in all modes
map <MiddleMouse>   <Nop>          " middle mouse does nothing
imap <MiddleMouse>  <Nop>


" Search Config
" -------------
set incsearch                      " find the next match as we type the search
set ignorecase                     " ignore the case of searches
set hlsearch                       " search with highlights by default
set smartcase                      " smart case-sensitivity when searching


" Indentation and Display
" -----------------------
set autoindent                     " copy the identation from the previous line
set expandtab                      " convert tabs to spaces
set tabstop=2                      " one tab is 2 spaces
set smarttab                       " use shiftwidth to tab at line beginning
set shiftwidth=2                   " width of autoindent
set nowrap                         " no wrapping
set showmatch                      " show matching brackets
set cursorline                     " highlight current line
set list                           " show whitespace
" show 'invisible' characters
set listchars=tab:▸\ ,trail:·,nbsp:_


" Scrolling
" ---------
set scrolloff=3                    " scroll when the cursor is 3 lines from edge


" Completion
" ----------
set wildmode=list:longest               " bash-like tab completion
set wildignore+=tags,tmp/**,build/**    " ignore tags, tmp and java build directories

" CtrlP Config
" ------------
let g:ctrlp_max_files=0            " No limit on the amount of files
let g:ctrlp_switch_buffer = 'et'   " If a file is already open, open it in a new pane instead of switching to the existing pane

" Use ripgrep https://github.com/BurntSushi/ripgrep
if executable('rg')
  " Use rg over Grep
  set grepprg=rg\ --no-heading\ --vimgrep

  " Use rg in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'rg %s -l --color=never --files'

  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'rg --vimgrep --smart-case'
endif
" use ctrlp-matcher for better matches
let g:ctrlp_match_func = { 'match' : 'matcher#cmatch' }
let g:ctrlp_working_path_mode = 'rw'


" Neocomplete Config
" ------------------
let g:acp_enableAtStartup = 0                             " Disable AutoComplPop.
let g:neocomplete#enable_at_startup = 1                   " Use neocomplete.
let g:neocomplete#enable_smart_case = 1                   " Use smartcase.
let g:neocomplete#sources#syntax#min_keyword_length = 3   " Set minimum syntax keyword length.
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()


" NERDTree Config
" ---------------
let NERDSpaceDelims = 1
map \           :NERDTreeToggle<CR>
map \|          :NERDTreeFind<CR>
map <leader>/   <plug>NERDCommenterToggle


" GUI Config
" ----------
set guioptions-=T                  " Remove GUI toolbar
set guioptions-=e                  " Use text tab bar, not GUI
set guioptions-=rL                 " Remove scrollbars
set guicursor=a:blinkon0           " Turn off the blinking cursor


" Custom Commands
" ---------------
" copy the current path
map <silent> <D-C> :let @* = expand("%:p")<CR>:echo "Copied: ".expand("%:p")<CR>
" copy the current path with line number
map <leader>C :let @* = expand("%:p").":".line(".")<CR>:echo "Copied: ".expand("%:p").":".line(".")<CR>

" hit space to clear search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""

" automatically strip whitespace on save
autocmd BufWritePre * if index(leave_trailing_white_space, &ft) < 0 | :%s/\s\+$//e
" except in markdown
let leave_trailing_white_space = ['md', 'markdown']

" save when switching buffers
set autowriteall                   " Save when doing various buffer-switching things.
autocmd BufLeave,FocusLost * silent! wall
