"
" .vimrc
"
" Vim configuration resource file. Specifies desired behavior for the vim editor
"
set nocompatible        " Forget compatibility with Vi. Who cares about Vi?
set showmode            " Show which mode you're in
set ruler               " Display cursor position in the lower right corner
"set number              " Line numbers. ruler makes this redundant
set showmatch           " Show matching [] () {} etc...
set smartindent         " Let vim help with indentation
set nowrap              " Do not wrap lines longer than the window
set scrolloff=5         " Minimum number of lines to keep above/below the cursor
syntax enable           " Syntax highlighting
set backspace=2         " Make Backspace work like you expect
set formatoptions+=ro   " Automatically insert the comment character when you
                        " hit <Enter> (r) or o/O (o) in a comment block

" Show invisible characters with `:set list!` or <F10>
set nolist
set listchars=tab:»-,trail:·,extends:>,precedes:<,eol:¬
noremap <F10> :set list!<CR>


" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! q !sudo tee > /dev/null %


" Tab options
set expandtab           " Soft tabs, changes tabs to spaces
set tabstop=4           " Number of spaces in a tab
set softtabstop=4       " Number of spaces in a soft tab
set shiftwidth=4        " Number of spaces in an indentation level.


" Use solarized colorscheme
set background=dark
colorscheme solarized


" Searching options
set nowrapscan          " Do not wrap to the top of the file while searching
set ignorecase          " Case insensitive searching
set smartcase           " Except when the query includes an uppercase character
set incsearch           " Begin matching query as you type it
set hlsearch            " Highlight search matches


" Code folding
"set foldmethod=indent
"set foldenable


" Make vim turn *off* expandtab for files named Makefile or makefile
" We need the tab literal
autocmd BufNewFile,BufRead [Mm]akefile* setlocal noexpandtab


" Put a vertical ruler in column 81
"highlight ColorColumn ctermbg=White
"set colorcolumn=81


" Set the terminal title to reflect the open file. Even works with Vim tabs.
autocmd BufEnter * let &titlestring = expand("%:t") . " - %{$USER}@" . hostname() | set title
autocmd VimLeave * let &titleold = $USER . "@" . hostname() | set title


" Filetype specific indentation
"filetype plugin indent on
"autocmd FileType html setlocal shiftwidth=2 softtabstop=2   " HTML
"autocmd FileType php setlocal shiftwidth=4 softtabstop=4    " PHP

" Map numpad keys in insert and command-line mode
"noremap! <Esc>Oq 1
"noremap! <Esc>Or 2
"noremap! <Esc>Os 3
"noremap! <Esc>Ot 4
"noremap! <Esc>Ou 5
"noremap! <Esc>Ov 6
"noremap! <Esc>Ow 7
"noremap! <Esc>Ox 8
"noremap! <Esc>Oy 9
"noremap! <Esc>Op 0
"noremap! <Esc>On .
"noremap! <Esc>OQ /
"noremap! <Esc>OR *
"noremap! <Esc>Ol +
"noremap! <Esc>OS -
"noremap! <Esc>OM <Enter>

" Map numpad keys in all other modes
"noremap <Esc>Oq 1
"noremap <Esc>Or 2
"noremap <Esc>Os 3
"noremap <Esc>Ot 4
"noremap <Esc>Ou 5
"noremap <Esc>Ov 6
"noremap <Esc>Ow 7
"noremap <Esc>Ox 8
"noremap <Esc>Oy 9
"noremap <Esc>Op 0
"noremap <Esc>On .
"noremap <Esc>OQ /
"noremap <Esc>OR *
"noremap <Esc>Ol +
"noremap <Esc>OS -
"noremap <Esc>OM <Enter>
