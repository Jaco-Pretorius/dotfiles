" use vim not vi
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" git helpers, mostly useful for :GBlame
Plugin 'tpope/vim-fugitive'

" shows git changes to the left of line numbers
" I stopped using this because it made tab switching slow - https://github.com/airblade/vim-gitgutter/issues/82
" Plugin 'airblade/vim-gitgutter'

" fuzzy search across all files in directory
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher', { 'do': 'CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments ./install.sh' }

" smart search within all files
Plugin 'mileszs/ack.vim'

" typing autocomplete using lua
Plugin 'Shougo/neocomplete.vim'

" tree-explorer view on demand
Plugin 'scrooloose/nerdtree'

" powerful commenting
Plugin 'scrooloose/nerdcommenter'

" Syntax
Plugin 'tpope/vim-endwise'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-ragtag'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'tpope/vim-markdown'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'leafgarland/typescript-vim'

" Colorschemes
Plugin 'junegunn/seoul256.vim'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-vividchalk'
Plugin 'obsidian2.vim'

call vundle#end()

filetype plugin indent on

" Appearance
" ----------
syntax on
syntax enable
if !has('gui_running')
  set t_Co=256
endif
set noshowmode
set background=dark
set guifont=Hack:h20
"set guifont=Victor\ Mono:h16
"colorscheme molokai
"colorscheme vividchalk
"colorscheme vwilight
"colorscheme seoul256
if has('gui_running')
  colorscheme obsidian2
else
  let g:seoul256_background = 233
  colorscheme seoul256
endif

" General Config
" --------------
let mapleader = ","
set number                         " show line numbers
set ruler                          " show column numbers
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
" let g:ctrlp_match_func = { 'match' : 'matcher#cmatch' }
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
map <leader>C :let @* = expand("%:p").":".line(".")<CR>:echo "Copied: ".expand("%:p").":".line(".")<CR>

" hit space to clear search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""

" automatically strip whitespace on save
" autocmd BufWritePre * if index(leave_trailing_white_space, &ft) < 0 | :%s/\s\+$//e
" except in markdown
let leave_trailing_white_space = ['md', 'markdown']

" save when switching buffers
set autowriteall                   " Save when doing various buffer-switching things.
autocmd BufLeave,FocusLost * silent! wall

" .axlsx files are ruby templates for excel
autocmd BufNewFile,BufRead *.axlsx set syntax=ruby

" .inky-erb files are inky templates that use erb
autocmd BufNewFile,BufRead *.inky-erb set syntax=eruby

autocmd Filetype ruby setlocal nocursorline

:silent command! -bang AV call OpenAssociatedFile("vsplit", <bang>0)
:silent command! -bang AS call OpenAssociatedFile("split", <bang>0)
function! OpenAssociatedFile(split_command, create_if_missing)
  let current_file_path = expand("%:")

  if current_file_path =~ "_spec\.rb$"
    let l:associated_file_path = substitute(substitute(current_file_path, "_spec\.rb$", ".rb", "g"), "\/spec\/", "/app/", "g")
  else
    if current_file_path =~ "\/lib\/" || current_file_path =~ "^lib\/"
      let l:associated_file_path = substitute(substitute(current_file_path, "lib\/", "spec/lib/", "g"), "\.rb$", "_spec.rb", "g")
    else
      let l:associated_file_path = substitute(substitute(current_file_path, "app\/", "spec/", "s"), "\.rb$", "_spec.rb", "g")
    end
  endif

  if !filereadable(l:associated_file_path) && current_file_path =~ "controller"
    let l:associated_file_path = substitute(substitute(substitute(substitute(current_file_path, "\/app\/", "/spec/", "s"), "\/controllers\/", "/requests/", "g"), "_controller", "", "g"), "\.rb$", "_spec.rb", "g")
  end
  if !filereadable(l:associated_file_path) && current_file_path =~ "\/spec\/requests\/"
    let l:associated_file_path = substitute(substitute(current_file_path, "\/spec\/requests\/", "/app/controllers/", "g"), "_spec\.rb$", "_controller.rb", "g")
  end

  if filereadable(l:associated_file_path) || a:create_if_missing
    execute a:split_command . " " . l:associated_file_path
  else
    echo "No file " . l:associated_file_path . " found"
  endif
endf

noremap <silent> gv :call BettermentCFile("vsplit")<cr>
noremap <silent> gs :call BettermentCFile("split")<cr>
noremap <silent> ge :call BettermentCFile("edit")<cr>

function! Snakecase(word)
  let word = substitute(a:word,'::','/','g')
  let word = substitute(word,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let word = substitute(word,'\(\l\|\d\)\(\u\)','\1_\2','g')
  let word = substitute(word,'[.-]','_','g')
  let word = tolower(word)
  return word
endf

function! FindFile(split_command, text)
  let ext = expand("%:e")
  let expected_file_name = shellescape(Snakecase(a:text) . "." . ext)
  let current_project = split(expand("%:"),"/")[0]

  let out = system("rg -l --files --color=never -g " . expected_file_name . " " . current_project . "/ | head -n 1")
  if len(out) == 0 && current_project == "retail" && ext == "rb"
    let out = system("rg -l --files --color=never -g " . expected_file_name . " investing/ | head -n 1")
  end
  if len(out) == 0 && (current_project == "investing" || current_project == "retail") && ext == "rb"
    let out = system("rg -l --files --color=never -g " . expected_file_name . " broker_dealer_core/ | head -n 1")
  end
  if len(out) == 0
    let out = system("rg -l --files --color=never -g " . expected_file_name . " | head -n 1")
  end

  if len(out) > 0
    execute a:split_command . " " . out
  else
    echo "Could not locate a file named " . expected_file_name
  endif
endf

" shamelessly copied from:
" https://github.com/tyru/open-browser.vim
" Get the last selected text in visual mode.
function! GetLastSelected()
  let save = getreg('"', 1)
  let save_type = getregtype('"')
  let [begin, end] = [getpos("'<"), getpos("'>")]
  try
    if visualmode() ==# "\<C-v>"
      let begincol = begin[2] + (begin[2] ># getline('.') ? begin[3] : 0)
      let endcol   =   end[2] + (  end[2] ># getline('.') ?       end[3] : 0)
      if begincol ># endcol
        " end's col must be greater than begin.
        let tmp = begin[2:3]
        let begin[2:3] = end[2:3]
        let end[2:3] = tmp
      endif
      let virtpadchar = ' '
      let lines = map(getline(begin[1], end[1]), '
                  \ (v:val[begincol-1 : endcol-1])
                  \ . repeat(virtpadchar, endcol-len(v:val))
                  \')
    else
      if begin[1] ==# end[1]
        let lines = [getline(begin[1])[begin[2]-1 : end[2]-1]]
      else
        let lines = [getline(begin[1])[begin[2]-1 :]]
                    \                   + (end[1] - begin[1] <# 2 ? [] : getline(begin[1]+1, end[1]-1))
                    \                   + [getline(end[1])[: end[2]-1]]
      endif
    endif
    return join(lines, "\n") . (visualmode() ==# "V" ? "\n" : "")
  finally
    call setreg('"', save, save_type)
  endtry
endf

function! GetSelectedText()
  let selected_text = GetLastSelected()
  let text = substitute(selected_text, '[\n\r]\+', ' ', 'g')
  return substitute(text, '^\s*\|\s*$', '', 'g')
endf

function! BettermentCFile(split_command)
  let selected_text = GetSelectedText()
  let visual_mode = mode() == "\<C-V>" || mode() == "v" || mode() == "V"
  if visual_mode && len(selected_text) > 0
    call FindFile(a:split_command, selected_text)
  else
    call FindFile(a:split_command, expand('<cword>'))
  endif
endf
