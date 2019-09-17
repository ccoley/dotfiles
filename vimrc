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
set showcmd             " Show commands as you type them
set smartindent         " Let vim help with indentation
set nowrap              " Do not wrap lines longer than the window
set linebreak           " Wrap long lines on whitespace instead of mid-word
set scrolloff=5         " Minimum number of lines to keep above/below the cursor
set backspace=2         " Make Backspace work like you expect
set formatoptions+=ro   " Automatically insert the comment character when you
                        " hit <Enter> (r) or o/O (o) in a comment block
set showbreak=└\        " Prefix wrapped continuation lines with '└ '
set commentstring=#%s   " The default comment style for line comments
let mapleader='\'       " The <leader> key for key maps
syntax enable           " Syntax highlighting
filetype plugin on      " Enable the filetype plugin


" Tab options
set expandtab           " Soft tabs, changes tabs to spaces
set tabstop=4           " Number of spaces in a tab
set softtabstop=4       " Number of spaces in a soft tab
set shiftwidth=4        " Number of spaces in an indentation level.


" Searching options
set nowrapscan          " Do not wrap to the top of the file while searching
set ignorecase          " Case insensitive searching
set smartcase           " Except when the query includes an uppercase character
set incsearch           " Begin matching query as you type it
set hlsearch            " Highlight search matches


" Enable modeline
set modeline
set modelines=5


" Code folding
"set foldmethod=indent
"set foldenable


" Use solarized colorscheme
set background=dark
colorscheme solarized


" Allow saving of files as sudo when I forget to start vim using sudo
cmap w!! w !sudo tee > /dev/null %


" Show invisible characters with `:set list!` or <F10>
set nolist
set listchars=tab:\|·,trail:·,nbsp:¤,extends:>,precedes:<,eol:¬
nnoremap <F10> :set list!<CR>


" Put a vertical ruler in columns 81 and 121
highlight ColorColumn ctermbg=magenta
nnoremap <F9> :call ToggleColorColumn()<CR>
function! ToggleColorColumn()
    if &colorcolumn
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,121
    endif
endfunction


" Associate extensions to filetypes
autocmd BufRead,BufNewFile *.gv setlocal filetype=dot


" Set the terminal title to reflect the open file. Even works with Vim tabs.
autocmd BufEnter * let &titlestring = expand("%:t") . " - %{$USER}@" . hostname() | setlocal title
autocmd VimLeave * let &titleold = $USER . "@" . hostname() | setlocal title


" Append a modeline at the end of a file.
"
" By default, it formats the modeline as a line comment so it gets ignored by
" anything that isn't Vim. You can override the commentstring by setting
" b:ml_commentstring to something else.
nnoremap <leader>ml :call AppendModeline()<CR>
function! AppendModeline()
    " Prefer b:ml_commentstring if it is set, otherwise use commentstring
    let l:commentstring = get(b:, 'ml_commentstring', &commentstring)
    let l:modeline = printf(l:commentstring, printf(" vi: set ts=%d sw=%d %set %sft=%s:", &ts, &sw, &et ? '' : 'no', &wrap ? 'wrap ' : '', &ft))
    call append(line("$"), l:modeline)
endfunction


" Filetype specific settings
autocmd FileType diff setlocal noet
autocmd FileType dot setlocal commentstring=//%s
autocmd FileType dns setlocal commentstring=;%s
autocmd FileType gitconfig setlocal commentstring=;%s
autocmd FileType go setlocal commentstring=//%s
autocmd FileType html setlocal commentstring=<!--%s-->
autocmd FileType less setlocal commentstring=/*%s*/
autocmd FileType markdown setlocal wrap commentstring=[_modeline]:\ #\ (%s\ )
autocmd FileType php setlocal commentstring=//%s
autocmd FileType plsql setlocal commentstring=--%s
autocmd FileType sass setlocal commentstring=//%s
autocmd FileType sql setlocal commentstring=--%s
autocmd FileType vim setlocal commentstring=\"%s
autocmd FileType yaml,ansible setlocal tabstop=2 shiftwidth=2 softtabstop=2


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
