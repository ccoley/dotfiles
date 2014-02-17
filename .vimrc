"
" .vimrc
"
" Vim configuration resource file.  Specifies desired
" behavior for the vim editor.
"
set showmode            " Tell you if you're in insert mode
set tabstop=4           " Set the tabstop to 4 spaces
set shiftwidth=4        " Shiftwidth should match tabstop
set expandtab           " Convert tabs to <tabstop> number of spaces
set nowrap              " Do not wrap lines longer than the window
set nowrapscan          " Do not wrap to the top of the file while searching
set ruler               " Show the cursor position all the time
set showmatch           " Show matching [] () {} etc...
set smartindent         " Let vim help you with your code indention
set nohlsearch          " Don't highlight strings you're searching for
set formatoptions+=ro   " Automatically insert the comment character when
                        " you hit <enter> (r) or o/O (o) in a block comment.
set backspace=2         " makes backspace work like you expect
set scrolloff=3         " Minimum number of lines to keep above and below the cursor

" Switch syntax highlighting on, when the terminal can support colors
if &t_Co > 2 || has("gui_running")
    syntax on

    " If using Putty and solarized doesn't look right, it's because you need
    " to edit the session colors. If you don't want to do that, then uncomment
    " the following 5 lines for a good solarized alternative
    "    
    "set t_Co=256
    "set background=dark
    "let g:solarized_termcolors=256
    "colorscheme solarized
    "highlight Comment  term=bold ctermfg=252 guifg=#d0d0d0
endif

" Make vim turn *off* expandtab for files named Makefile or makefile
" We need the tab literal
autocmd BufNewFile,BufRead [Mm]akefile* set noexpandtab

" Make vim recognize a file ending in ".template" as a C++ source file
autocmd BufNewFile,BufRead *.template set ft=cpp

" Make vim highlight any characters in columns 81+
"highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
"match OverLength '\%81v.*'

" Set the terminal title to reflect the open file. Even works with Vim tabs.
autocmd BufEnter * let &titlestring = expand("%:t") . " - %{$USER}@" . hostname() | set title
