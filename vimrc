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


" Modeline options
set modeline            " Enable the Vim modeline in files
set modelines=5         " The number of lines to check for :set commands


" Code folding
"set foldmethod=indent
"set foldenable


" Use solarized colorscheme
set background=dark
colorscheme solarized


" Allow saving of files as sudo when I forget to start vim using sudo
cmap w!! w !sudo tee > /dev/null %


" Show invisible characters. Toggle with <F10>
set nolist
set listchars=tab:\|·,trail:·,nbsp:¤,extends:>,precedes:<,eol:¬
nnoremap <silent> <F10> :set list!<CR>


" Put a vertical ruler in columns 81 and 121. Toggle with <F9>
highlight ColorColumn ctermbg=magenta
nnoremap <silent> <F9> :call ToggleColorColumn()<CR>
function! ToggleColorColumn()
    if &colorcolumn
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,121
    endif
endfunction


" Set the terminal title to reflect the open file. Even works with Vim tabs.
autocmd BufEnter * let &titlestring = expand("%:t") . " - %{$USER}@" . hostname() | setlocal title
autocmd VimLeave * let &titleold = $USER . "@" . hostname() | setlocal title


" Append a modeline at the end of a file. Call with `<leader>ml`
"
" By default, it formats the modeline as a line comment so it gets ignored by
" anything that isn't Vim. You can override the commentstring by setting
" b:ml_commentstring to something else.
nnoremap <leader>ml :call AppendModeline()<CR>
function! AppendModeline()
    " Prefer b:ml_commentstring if it is set, otherwise use commentstring
    let l:commentstring = get(b:, 'ml_commentstring', &commentstring)
    let l:modeline = printf(l:commentstring, printf("vi: set ts=%d sw=%d %set %sft=%s:", &ts, &sw, &et ? '' : 'no', &wrap ? 'wrap ' : '', &ft))
    call append(line("$"), l:modeline)
endfunction


" vi: set ts=4 sw=4 et ft=vim:
