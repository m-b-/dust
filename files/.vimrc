" This file contains vim remapping assuming:
"   - a bépo keyboard
"   - control remaped to caps-lock, or at least easily available.

"   ____                           _            _   _   _
"  / ___| ___ _ __   ___ _ __ __ _| |  ___  ___| |_| |_(_)_ __   __ _ ___
" | |  _ / _ \ '_ \ / _ \ '__/ _` | | / __|/ _ \ __| __| | '_ \ / _` / __|
" | |_| |  __/ | | |  __/ | | (_| | | \__ \  __/ |_| |_| | | | | (_| \__ \
"  \____|\___|_| |_|\___|_|  \__,_|_| |___/\___|\__|\__|_|_| |_|\__, |___/
"                                                               |___/

" -------
" General
" -------

" Don't be vi-compatible
set nocompatible

" Clear auto command to avoid launching twice
autocmd!

" Allow backspacing over indentation, eol, start of line
" in insert mode.
set backspace=indent,eol,start

" Keep that much lines of history
set history=5000

" And that much undo levels
set undolevels=5000

" No beeps
set noerrorbells

" By default, use the /g flags in substitution
set gdefault

" Automatically write before using :next or :make
set autowrite

" Error format output
set errorformat=%f:%l:%m

" Ignore those extensions in auto-completion
set wildignore=*.o,*.~,*.swp

" Don't jump to start of line automatically
" (go to first non-blank character)
set nostartofline

" Show current mode
set showmode

" Display incomplete command
set showcmd

" Disable auto-read. This is nice, but many files have changed, an army
" of popup will rise. Be wise.
set noautoread

" Update swap file every 50 characters
set updatecount=50

" Rebuild documentation tags at startup
" (not that this may cause an overhead at startup, but as long as we don't
" have that much plugin, it doesn't matter).
helptags ~/.vim/doc/

if has("autocmd")
    " Set text width to 80 columns at most
    autocmd FileType * setlocal textwidth=80

    " Jump to last position when opening a file (from default configuration)
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g'\""                           |
        \ endif
endif

" use a tree-style output in explore mode
let g:netrw_liststyle=3

" --------
" Encoding
" --------

" Set default encoding to utf8
set encoding=utf-8
set fileencoding=utf-8

" ----------
" Identation
" ----------

" Copy previous line's indentation
set autoindent

" Number of spaces to display a tab
set tabstop=4

" Number of spaces in shifting (>>, <<)
set shiftwidth=4

" How many spaces to insert instead of tab
set softtabstop=4

" Do not use tabulations, only spaces
set expandtab

" ------
" Search
" ------

" But don't ignore it if uppercase chars in search.
set smartcase

" Jump to matches while entering the pattern.
set showmatch

" Begin search at the top of the file when EOL reached.
set wrapscan

" Highlight all matches.
set hlsearch

" Highlight all matches when entering the pattern.
set incsearch

" By default, ignore case in research.
set ignorecase

" -----
" Mouse
" -----

" Use the mouse
set mouse=a

" Hide the mouse when typing
set mousehide

" -------
" Backups
" -------

" Don't pollute the trees
set backupdir=~/.vim/backups

" We want backup all the time
set backup

"   ____      _
"  / ___|___ | | ___  _ __ ___
" | |   / _ \| |/ _ \| '__/ __|
" | |__| (_) | | (_) | |  \__ \
"  \____\___/|_|\___/|_|  |___/
"

" -------------------
" Syntax highlighting
" -------------------
filetype plugin indent on
syntax enable

" ---
" GUI
" ---
if has("gui_running")
    " Disable menus in gvim
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L

    " Set color theme
    set background=light
    colorscheme solarized
else
    set background=dark
endif

" -----------
" Bad spacing
" -----------
" NOTE: this needs to be after colorscheme.
" NOTE: At of today, this doesn't work, or doesn't work all the time. Likely,
" this is being reset by later configuration.

" Highlight non-breakable spaces
syntax match NbSp /\%xa0/

" Highlight spaces at the end
syntax match EndSp /\s\+$/

" NOTE: this needs to be *after* syntax match.
highlight NbSp  ctermbg=lightgray guibg=lightred
highlight EndSp ctermbg=lightgray guibg=lightmagenta

" Highlight current word by storing it escaped
" in the search register (@/). Assumes hlsearch is set.
nnoremap // :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>

"   ____            _             _
"  / ___|___  _ __ | |_ _ __ ___ | |
" | |   / _ \| '_ \| __| '__/ _ \| |
" | |__| (_) | | | | |_| | | (_) | |
"  \____\___/|_| |_|\__|_|  \___/|_|
"
"                              _
"  _ __ ___   __ _ _ __  _ __ (_)_ __   __ _ ___
" | '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` / __|
" | | | | | | (_| | |_) | |_) | | | | | (_| \__ \
" |_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                 |_|   |_|            |___/

" ----------------
" Escape key and :
" ----------------

" Way faster to hit than escape; the "auto-write" feature is a must.
" TODO: C-s is not usable on bare terminal.
inoremap <C-s> <esc>:w<CR>
noremap  <C-s> <esc>:w<CR>
inoremap <C-S> <esc>:wa<CR>
noremap  <C-S> <esc>:wa<CR>

" : is shift-. while , is damn close.
noremap , :

" ----
" Quit
" ----
"noremap <C-q> <esc>:q<CR>

"  _____         _                                 _
" |_   _|____  _| |_   _ __ ___   __ _ _ __  _ __ (_)_ __   __ _ ___
"   | |/ _ \ \/ / __| | '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` / __|
"   | |  __/>  <| |_  | | | | | | (_| | |_) | |_) | | | | | (_| \__ \
"   |_|\___/_/\_\\__| |_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                                     |_|   |_|            |___/

" --------------
" Byte movements
" --------------

" [HJKL] -> {CTSR}
noremap c h
noremap r l
noremap t j
noremap s k
noremap C H
noremap R L
noremap T J
noremap S K

" {HJKL} <- [CTSR]
noremap j t
noremap J T
noremap l c
noremap L C
noremap h r
noremap H R
noremap k s
noremap K S

" --------------
" Word movements
" --------------

" Append after the end of current word.
noremap E ea

" --------------
" Line movements
" --------------

" Beginning/End of line; classical unix move
inoremap <C-a> <esc>0i
inoremap <C-e> <esc>$a
noremap  <C-a> 0
noremap  <C-e> $

" -------------------
" Paragraph movements
" -------------------

" This is AltGr-t and AltGr-s on bépo.
noremap þ }
noremap ß {

" -------------------
" Scrolling movements
" -------------------

" This is AltGr-c and AltGr-r on bépo.
noremap © <PageDown>
noremap ® <PageUp>

" ---------
" Selection
" ---------

" Stay in visual mode when indenting.
" (not always the best option...)
vnoremap < <gv
vnoremap > >gv

" This is AltGr-a on bépo (select all file)
noremap æ ggVG

"  ____         __  __            ____        ___           _
" | __ ) _   _ / _|/ _| ___ _ __ / /\ \      / (_)_ __   __| | _____      __
" |  _ \| | | | |_| |_ / _ \ '__/ /  \ \ /\ / /| | '_ \ / _` |/ _ \ \ /\ / /
" | |_) | |_| |  _|  _|  __/ | / /    \ V  V / | | | | | (_| | (_) \ V  V /
" |____/ \__,_|_| |_|  \___|_|/_/      \_/\_/  |_|_| |_|\__,_|\___/ \_/\_/
"
"                              _
"  _ __ ___   __ _ _ __  _ __ (_)_ __   __ _ ___
" | '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` / __|
" | | | | | | (_| | |_) | |_) | | | | | (_| \__ \
" |_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                 |_|   |_|            |___/

" ----------------
" Window movements
" ----------------
noremap <silent> <M-c> <esc>:wincmd h<CR>
noremap <silent> <M-t> <esc>:wincmd j<CR>
noremap <silent> <M-s> <esc>:wincmd k<CR>
noremap <silent> <M-r> <esc>:wincmd l<CR>

" --------------
" Windows resize
" --------------
noremap <silent> <C-MouseUp> <esc>:resize +5<CR>
noremap <silent> <C-MouseDown> <esc>:resize -5<CR>
noremap <silent> <M-MouseUp> <esc>:vertical resize +5<CR>
noremap <silent> <M-MouseDown> <esc>:vertical resize -5<CR>

" ----------------
" Buffer movements
" ----------------
noremap <silent> <M-T> <esc>:bp<CR>
noremap <silent> <M-S> <esc>:bn<CR>

"noremap <silent> <C-MouseUp>   <esc>:bn<CR>
"noremap <silent> <C-MouseDown> <esc>:bp<CR>

" --------------
" Buffer closing
" --------------

" , is mapped to : so this mimics :bdd.
command! DD :bp\|bd #<CR>

" -------------
" Tab movements
" -------------
noremap <silent> <M-R> <esc>:tabnext<CR>
noremap <silent> <M-C> <esc>:tabprev<CR>

"   ___  _   _                                             _
"  / _ \| |_| |__   ___ _ __   _ __ ___   __ _ _ __  _ __ (_)_ __   __ _ ___
" | | | | __| '_ \ / _ \ '__| | '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` / __|
" | |_| | |_| | | |  __/ |    | | | | | | (_| | |_) | |_) | | | | | (_| \__ \
"  \___/ \__|_| |_|\___|_|    |_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                                             |_|   |_|            |___/
" -----
" Boxes
" -----

" TODO: conflicts for C-f C-b?
" INFO: "box" script:
"   #!/usr/bin/perl
"   print '-'x length,"\n$_\n",'-'x length,"\n" while chomp($_=<>);
if has("autocmd") && executable("figlet") && executable("box")
    " Comments differs following files
    autocmd FileType vim
        \ noremap <silent> <C-f> <esc>V:!figlet\|sed 's/^/" /;s/\s\+$//'<CR>|
        \ noremap <silent> <C-b> <esc>V:!box\|sed 's/^/" /'<CR>
endif

" -----
" Paste
" -----

" By default when hitting p over something, the something will be set into the
" default register. This will send it to the blackhole register, so we can keep
" it.
vnoremap <leader>p "_dP

" -------
" Quoting
" -------

noremap qw' <esc>bi'<esc>ea'<esc>
noremap qw" <esc>bi"<esc>ea"<esc>

"  ____           _            _   _   _
" |  _ \ ___ _ __| |  ___  ___| |_| |_(_)_ __   __ _ ___
" | |_) / _ \ '__| | / __|/ _ \ __| __| | '_ \ / _` / __|
" |  __/  __/ |  | | \__ \  __/ |_| |_| | | | | (_| \__ \
" |_|   \___|_|  |_| |___/\___|\__|\__|_|_| |_|\__, |___/
"                                              |___/

if has("autocmd")
    " Most of the time, we want Template Tookit files to be highlighted as HTML.
    au BufNewFile,BufRead *.tt setlocal ft=html

    " Consider ':' as a word separator (mainly for Perl::Modules).
    " Its is however temporarily override for ctags so we can look
    " for Foo::Bar::baz().
    "
    " C-n and M-n are redefined later on for tag setting,
    autocmd FileType perl
        \ noremap <silent> <C-f> <esc>V:!figlet\|sed 's/^/\# /;s/\s\+$//'<CR>|
        \ noremap <silent> <C-b> <esc>V:!box\|sed 's/^/\# /'<CR>|
        \ set iskeyword-=:|
        \ noremap <silent> <C-n> <esc>:set iskeyword+=:<CR><C-]>:set iskeyword-=:<CR>|
        \ noremap <silent> <M-n> <esc>:set iskeyword+=:<CR>:vsp <CR>:exec("tag ".expand("<cword>"))<CR>:set iskeyword-=:<CR>|
        \ noremap <silent> <M-N> <esc>:set iskeyword+=:<CR>:sp <CR>:exec("tag ".expand("<cword>"))<CR>:set iskeyword-=:<CR>|
        \ iab dbp use Data::Dumper; print STDERR Dumper|
        \ iab stp use Devel::StackTrace; print STDERR Devel::StackTrace->new()->as_string()
endif

"       \ setlocal textwidth=9999|

"  ____        _   _                            _   _   _
" |  _ \ _   _| |_| |__   ___  _ __    ___  ___| |_| |_(_)_ __   __ _ ___
" | |_) | | | | __| '_ \ / _ \| '_ \  / __|/ _ \ __| __| | '_ \ / _` / __|
" |  __/| |_| | |_| | | | (_) | | | | \__ \  __/ |_| |_| | | | | (_| \__ \
" |_|    \__, |\__|_| |_|\___/|_| |_| |___/\___|\__|\__|_|_| |_|\__, |___/
"        |___/                                                  |___/
if has("autocmd")
    " Set line witdh to 72 bytes max (PEP8).
    autocmd FileType python
        \ noremap <silent> <C-f> <esc>V:!figlet\|sed 's/^/\# /;s/\s\+$//'<CR>|
        \ noremap <silent> <C-b> <esc>V:!box\|sed 's/^/\# /'<CR>|
        \ setlocal textwidth=72
endif

"      _ ____             _   _   _
"     | / ___|   ___  ___| |_| |_(_)_ __   __ _ ___
"  _  | \___ \  / __|/ _ \ __| __| | '_ \ / _` / __|
" | |_| |___) | \__ \  __/ |_| |_| | | | | (_| \__ \
"  \___/|____/  |___/\___|\__|\__|_|_| |_|\__, |___/
"                                         |___/
if has("autocmd")
    autocmd FileType javascript
        \ noremap <silent> <C-f> <esc>V:!figlet\|sed 's/^/\/\/ /;s/\s\+$//'<CR>|
        \ noremap <silent> <C-b> <esc>V:!box\|sed 's/^/\/\/ /'<CR>|
        \ setlocal textwidth=80
endif

"  ____  _          _ _            _   _   _
" / ___|| |__   ___| | |  ___  ___| |_| |_(_)_ __   __ _ ___
" \___ \| '_ \ / _ \ | | / __|/ _ \ __| __| | '_ \ / _` / __|
"  ___) | | | |  __/ | | \__ \  __/ |_| |_| | | | | (_| \__ \
" |____/|_| |_|\___|_|_| |___/\___|\__|\__|_|_| |_|\__, |___/
"                                                  |___/

if has("autocmd")
    autocmd FileType sh
        \ noremap <silent> <C-f> <esc>V:!figlet\|sed 's/^/\# /;s/\s\+$//'<CR>|
        \ noremap <silent> <C-b> <esc>V:!box\|sed 's/^/\# /'<CR>
endif

"  _____                          _   _   _
" |_   _|_ _  __ _ ___   ___  ___| |_| |_(_)_ __   __ _ ___
"   | |/ _` |/ _` / __| / __|/ _ \ __| __| | '_ \ / _` / __|
"   | | (_| | (_| \__ \ \__ \  __/ |_| |_| | | | | (_| \__ \
"   |_|\__,_|\__, |___/ |___/\___|\__|\__|_|_| |_|\__, |___/
"            |___/                                |___/

" Set tag file; this will look in parent directory
" until a match is found (and will thus work in subdirs)
set tags=tags;/

" Temporarily add ':' to the list of keyword, the time to issue
" a tag search with word under cursor. Useful for Perl.
" TODO: issue with Perl settings
"noremap <silent> <C-n> <C-]>

" Same as C-n but opens-up a finding in a vertical panel.
"noremap <silent> <M-n> <esc>:vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"  ____                _
" / ___|  ___  ___ ___(_) ___  _ __  ___
" \___ \ / _ \/ __/ __| |/ _ \| '_ \/ __|
"  ___) |  __/\__ \__ \ | (_) | | | \__ \
" |____/ \___||___/___/_|\___/|_| |_|___/
"

" What to save when creating a session
set sessionoptions=buffers,curdir,resize,folds,globals,winpos,winsize

" Create a new session (dump current work)
cnoremap <C-x> <esc>:mksession!<CR>

"  ____  _        _               _ _
" / ___|| |_ __ _| |_ _   _ ___  | (_)_ __   ___
" \___ \| __/ _` | __| | | / __| | | | '_ \ / _ \
"  ___) | || (_| | |_| |_| \__ \ | | | | | |  __/
" |____/ \__\__,_|\__|\__,_|___/ |_|_|_| |_|\___|
"

" Always show status line.
set laststatus=2

" Make the status line a little more informative.
set statusline=%F%m%r%h%w\ 

" Append git's information if any
highlight link User1 Identifier
set statusline+=%1*[%{fugitive#head()}]%*

" Now, align to the right
set statusline+=%=

" And display current position in the file
set statusline+=%04l,%03v\ \ \ \ %P

"     _         _                    _       _ _       ____
"    / \  _   _| |_ ___    _ __ ___ | | ____| (_)_ __ / /\ \
"   / _ \| | | | __/ _ \  | '_ ` _ \| |/ / _` | | '__| |  | |
"  / ___ \ |_| | || (_) | | | | | | |   < (_| | | |  | |  | |
" /_/   \_\__,_|\__\___/  |_| |_| |_|_|\_\__,_|_|_|  | |  | |
"                                                     \_\/_/

" Automatically call mkdir -p when saving a file when parent directory doesn't
" exists.
" Taken from: https://stackoverflow.com/a/4294176
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
