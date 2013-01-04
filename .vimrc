"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call pathogen#infect()
set nocompatible	" Use Vim defaults (much better!)
filetype plugin indent on


set mouse-=a " Disable mouse
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

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

au Filetype html,xsl,eruby,xml source ~/.vim/bundle/closetag/plugin/closetag.vim

set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set cursorline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set wildmenu "Turn on WiLd menu
set ruler		" show the cursor position all the time
set number
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
set guifont=YaHei\ Consolas\ Hybrid\ 10
set t_Co=256
set background=dark
"colors herald
"let g:molokai_original = 1
"colors molokai
"colors peaksea
"colors ir_black
colors solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backupdir=~/.vimruntime/backup
set directory=~/.vimruntime/swap
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

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <C-h> ""y:%s/<C-R>=escape(@", '~./\')<CR>//gc<Left><Left><Left>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart way to move btw. windows
map j <c-w>j
map k <C-W>k
map h <C-W>h
map l <C-W>l
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

function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

"Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c\ %{CurrentTag()}

function! CurrentTag() 
  let current_tag = tagbar#currenttag('[%s] ','')
  return current_tag
endfunction

function! CurDir()
    let curdir = substitute(getcwd(), '/home/dsun/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("[%y-%m-%d %H:%M:%S]")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
"nmap <M-j> mz:m+<cr>`z
"nmap <M-k> mz:m-2<cr>`z
vmap j :m'>+<cr>`<my`>mzgv`yo`z
vmap k :m'<-2<cr>`>my`<mzgv`yo`z
"Alt key
"inoremap  i <ESC>


"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

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

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
"nnoremap z/ :call AutoHighlightToggle()<CR>
"function! AutoHighlightToggle()
"  let @/ = ''
"  if exists('#auto_highlight')
"    au! auto_highlight
"    augroup! auto_highlight
"    setl updatetime=4000
"    echo 'Highlight current word: off'
"    return 0
"  else
"    augroup auto_highlight
"      au!
"      au CursorHold * let @/ = '\<'.expand('<cword>').'\>'
"    augroup end
"    setl updatetime=500
"    echo 'Highlight current word: ON'
"    return 1
"  endif
"endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>

""""""""""""""""""""""""""""""
" => LESS syntax 
""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.less set filetype=less

""""""""""""""""""""""""""""""
" => Command-T
""""""""""""""""""""""""""""""
"let g:CommandTMaxHeight = 15
"let g:CommandTMatchWindowReverse = 1
"noremap <leader>j :CommandT<cr>
"noremap <leader>r :CommandTJump<cr>
"noremap <leader>y :CommandTFlush<cr>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
"let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
"set grepprg=/bin/grep\ -nH

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>pp :setlocal paste!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""
"  Customize file type and related
""""""""""""""""""""""""""""""""""""""""""""""""""
" supertab
let g:SuperTabDefaultCompletionType = "context"

" Ruby syntax(ruby.vim)
let ruby_operators = 1
let ruby_space_errors = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Project 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:proj_flags = "gsm" "g: F<12> to toggle Project window; s: syntax highlighting in Project window, 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <Leader>P :NERDTreeToggle<CR>
nmap <silent> <Leader>f :NERDTreeFind<CR>
nmap <silent> <leader>F :NERDTreeFind<CR>
let NERDTreeShowBookmarks = 1
"let NERDTreeWinSize = 40
"autocmd vimenter * NERDTree
autocmd vimenter * if !argc() |  NERDTree | endif
let NERDTreeChDirMode = 2

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


"HERE document
"imap <<- <<-QUOTE<CR><Tab><CR>QUOTE<Esc>-A

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Surround 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:surround_45 = "<% \r %>" " yss-
let g:surround_61 = "<%= \r %>" " yss=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rails
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:rails_default_file='db/config.yml'
"let g:rails_default_database='sqlite3'
"let g:rails_menu=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>l :TagbarToggle<CR>
let g:tagbar_autoshowtag = 1
let g:tagbar_compact = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctags http://vim.wikia.com/wiki/C%2B%2B_code_completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make the vim search tag file from current directory all the way up to root dir
set tags=tags
set tags+=~/system/stl.tags
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 0
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
let OmniCpp_LocalSearchDecl = 1
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
set completeopt=menuone,menu,longest

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
" autocscope  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
" Disable autocscope mappings and define my own Cscope mappings  
let g:autocscope_menus=0
nnoremap <C-w>\ :scs find c <C-R>=expand("<cword>")<CR><CR>  
nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>  
nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
" gtags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
"let GtagsCscope_Auto_Load = 1
"let GtagsCscope_Auto_Map = 1
"let GtagsCscope_Quiet = 1
"let GtagsCscope_Absolute_Path = 1
"set cscopetag

command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*.o,*.obj,.git,*.pyc,*.class
let g:ctrlp_root_markers = ['.bmtoplevelmarker'] 
let g:ctrlp_clear_cache_on_exit = 0
nnoremap <leader>r :CtrlPMRUFiles<CR>
nnoremap <leader>t :CtrlPBufTag<CR>
nnoremap <leader>T :CtrlPBufTagAll<CR>
nnoremap <leader>m :CtrlPBookmarkDir<CR>
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 50
"let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_by_filename = 1
"Ignore the fusion project directory **/bin/fusion-rhel-x86_64-gnu/
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](bin\/fusion-rhel-x86_64-gnu|fusion\/build\/root|fusion\/components\/(fusion\.mgmt|gui)|fusion\/(testing|commons|os)|fusion\/thirdparty\/images)$',
      \ 'file': '\v\.(d|so|dll)$',
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ConqueTerm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ConqueTerm_Color = 2
let g:ConqueTerm_TERM = 'xterm-color'
