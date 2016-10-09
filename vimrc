" Required settings for Vundle - Vim plug-in manager
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" All plugins must be added between vundle#begin and vundle#end

Plugin 'VundleVim/Vundle.vim' " Let Vundle manage Vundle, required

" Color schemes
Bundle 'altercation/vim-colors-solarized'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on 

let mapleader = ","

" Syntax highlighting and colors
syntax enable
colorscheme tomorrow-night-bright

" Filetype settings
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Whitespace & Tab configuration
set encoding=utf-8    " Necessary to show unicode glyphs
set expandtab         " Use soft tabs
set tabstop=2
set autoindent
set smarttab          " Use shiftwidth to tab at line beginning
set shiftwidth=2      " Width of autoindent
set list              " Show whitespace
set listchars=trail:·

" Strip trailing whitespace before saving a file
function! StripTrailingWhitespace()
  let save_cursor = getpos(".")
  %s/\s\+$//e
  call setpos('.', save_cursor)
endfunction
autocmd BufWritePre *.* call StripTrailingWhitespace()

" Editor configuration
set autowriteall                " Save when switching buffers
set showmatch                   " Show matching brackets
set hidden                      " Allow hidden, unsaved buffers
set splitright                  " Add new windows towards the right
set splitbelow                  " Add new windows towards the  bottom
set wildmode=list:longest       " Bash-like tab completion
set incsearch                   " Incremental search
set scrolloff=3                 " Scroll when the cursor is 3 lines from edge
set cursorline                  " Highlight current line
set backspace=indent,eol,start  " Let backspace work over anything.
