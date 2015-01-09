"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on


" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Avoiding VIM keep scanning /usr/include when auto-completing 
set path=.

set history=1000		" keep 1000 lines of command line history
set autoread
set hidden
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,gb2312,gbk,gb18030
endif
set diffopt=filler,vertical,iwhite,context:4


" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
"autocmd! bufwritepost .vimrc source ~/.vimrc

"By default, pressing <TAB> in command mode will choose the first possible
"completion with no indication of how many others there might be. 
"To have the completion behave similarly to a shell, i.e. complete only up to
"the point of ambiguity (while still showing you what your options are), also
"add the following:set wildmode=list:longest
set wildmode=list:longest
let loaded_matchparen = 1 " Don't load the matchparen plugin

augroup filetypedetect
    au! BufRead,BufNewFile *.eruby      setfiletype eruby
    au! BufRead,BufNewFile rfc*.txt    setfiletype rfc
    au! BufRead,BufNewFile *.thrift      setfiletype thrift
    au! BufNewFile,BufRead *.less set filetype=less
augroup END

augroup vimEx
  "     When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
augroup END
"au filetype java compiler ant | set makeprg=mvn\ -q\ -f\ pom.xml\ 
"au filetype java compiler maven2 | setlocal omnifunc=javacomplete#Complete | setlocal completefunc=javacomplete#CompleteParamsInfo 
"au filetype ruby compiler ruby

set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set cursorline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set wildmenu "Turn on WiLd menu
set ruler		" show the cursor position all the time
"set number
" Set backspace config
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l

"These two options, when set together, will make /-style searches
"case-sensitive only if there is a capital letter in the search expression.
"*-style searches continue to be consistently case-sensitive. 
set ignorecase 
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl
set encoding=utf-8
set fileencodings=utf-8,chinese,latin1
set t_Co=256
set background=dark
"colors herald
"let g:molokai_original = 1
"colors molokai
"colors peaksea
"colors ir_black
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colors solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backupdir=~/.vimruntime/backup//
set directory=~/.vimruntime/swap//
"Persistent undo
"set undodir=~/.vimruntime/undo
"set undofile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab
set linebreak
set textwidth=500
set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart way to move btw. windows
" Mapping under urxvt
map j <c-w>j
map k <C-W>k
map h <C-W>h
map l <C-W>l
" Mapping under gvim
map <A-j> <c-w>j
map <A-k> <c-w>k
map <A-h> <C-W>h
map <A-l> <C-W>l

" GVIM Options
" Disable Menu Alt key in GVIM
set wak=no
"set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=l  "remove left-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=b  "remove bottom scroll bar
"set mouse=a " Enable mouse
set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12


" Window resizing mappings 
nnoremap + <c-w>+
nnoremap - <c-w>-
nnoremap < <c-w><
nnoremap > <c-w>>
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>
" Quick swith to the last buffer
map <leader>a <C-^>
" Switching line number
nnoremap <leader>N :setlocal number!<cr>

"nnoremap <C-h> :tabprevious<CR>
"nnoremap <C-l> :tabnext<CR>
" Specify the behavior when switching between buffers 
set switchbuf=usetab
set stal=0

" Folding of (gnu)make output.
"au BufReadPost quickfix setlocal foldmethod=marker
"au BufReadPost quickfix setlocal foldmarker=Entering\ directory,Leaving\ directory
"au BufReadPost quickfix map <buffer> <silent> zq zM:g/error:/normal zv<CR>
"au BufReadPost quickfix map <buffer> <silent> zw zq:g/warning:/normal zv<CR>
"au BufReadPost quickfix normal zq


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
"nmap <M-j> mz:m+<cr>`z
"nmap <M-k> mz:m-2<cr>`z
vmap j :m'>+<cr>`<my`>mzgv`yo`z
vmap k :m'<-2<cr>`>my`<mzgv`yo`z
" Map under gvim
vmap <A-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <A-k> :m'<-2<cr>`>my`<mzgv`yo`z
"Alt key
"inoremap  i <ESC>


" pressing < or > will let you indent/unident selected lines
vnoremap < <gv
vnoremap > >gv
" run shell
set shell=bash\ --login
nnoremap <silent> <S-F9> :shell<CR>
nnoremap <silent> <F3> :set hlsearch!<CR>

"The following will make tabs and trailing spaces visible when requested
set listchars=tab:>-,eol:$
nmap <silent> <leader>v :set nolist!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>pp :setlocal paste!<cr>

" Ruby syntax(ruby.vim)
let ruby_operators = 1
let ruby_space_errors = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Java Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let java_highlight_all=1
let rava_highlight_java_lang_ids=1
let java_highlight_debug=1

let java_ignore_javadoc=0
let java_highlight_functions="indent"
let java_mark_braces_in_parens_as_errors=1
let java_allow_cpp_keywords=0
let java_javascript=1
let java_css=1
let java_vb=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
" Cscope  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  

" Use both cscope and ctag  
set cscopetag  

" Show msg when cscope db added  
set cscopeverbose  

" Use tags for definition search first  
set cscopetagorder=1  

" Use quickfix window to show cscope results  
set cscopequickfix=s-,c-,d-,i-,t-,e-  


"Save the file using sudo
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!


let g:agprg="/home/dsun/tools/bin/ag"


if executable("zsh")
  set shell=zsh\ -l
endif
