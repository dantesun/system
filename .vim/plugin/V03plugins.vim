
"Buffergator
let g:buffergator_suppress_keymaps=1 
map <leader>o :BuffergatorOpen<cr>
let g:buffergator_viewport_split_policy="B"
nnoremap <S-H> :bn<CR>
nnoremap <S-L> :BuffergatorMruCycleNext<CR>

" supertab
let g:SuperTabDefaultCompletionType = "context"

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
let NERDTreeWinPos="right"

" Prevent :bd inside NERDTree buffer
au FileType nerdtree cnoreabbrev <buffer> bd <nop>
au FileType nerdtree cnoreabbrev <buffer> BD <nop>

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" Always show status line. Fix the problem AirLine dispappears when NerdTree is toggle off
set laststatus=2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>l :TagbarToggle<CR>
let g:tagbar_autoshowtag = 0
let g:tagbar_compact = 1
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_autofocus = 0
let g:tagbar_indent = 1
autocmd BufNewFile,BufReadPre,BufReadPost cfgMgr.h let b:tagbar_ignore = 1
autocmd BufNewFile,BufReadPre,BufReadPost RcObjectGen.cc let b:tagbar_ignore = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctags http://vim.wikia.com/wiki/C%2B%2B_code_completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make the vim search tag file from current directory all the way up to root dir
set tags=tags;
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
set completeopt=menuone,menu,longest,preview
"set completeopt=menuone,menu,longest

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ack.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ag is faster than ack
let g:ackprg = 'ag --nogroup --nocolor --column --ignore cscope.out --ignore tags --ignore "*.java" --ignore "*.d"'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*.o,*.obj,.git,*.pyc,*.class
let g:ctrlp_root_markers = ['.bmtoplevelmarker'] 
let g:ctrlp_clear_cache_on_exit = 0
"200ms deplay
let g:ctrlp_lazy_update = 200
nnoremap <leader>r :CtrlPMRUFiles<CR>
nnoremap <leader>t :CtrlPBufTag<CR>
nnoremap <leader>T :CtrlPBufTagAll<CR>
nnoremap <leader>m :CtrlPBookmarkDir<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 50
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_by_filename = 1
"Ignore the fusion project directory **/bin/fusion-rhel-x86_64-gnu/
"let g:ctrlp_custom_ignore = {
"      \ 'dir':  '\v[\/](bin\/fusion-rhel-x86_64-gnu|fusion\/build\/root|fusion\/components\/(fusion\.mgmt|gui)|fusion\/(testing|commons|os)|fusion\/thirdparty\/images)$',
"      \ 'file': '\v\.(d|so|dll)$',
"      \ }
"let g:ctrlp_user_command = 'ack -f --nojava --ignore-dir=os --ignore-dir=testing %s'       " MacOSX/Linux
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  INI EnhCommentify comment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function EnhCommentifyCallback(ft)
  if a:ft == 'ini'
    let b:ECcommentOpen = ';'
    let b:ECcommentClose = ''
  endif
endfunction
let g:EnhCommentifyCallbackExists = 'Yes'
"airline
let g:airline_powerline_fonts=1
"jedi-vim
let g:jedi#use_tabs_not_buffers=0
let g:jedi#completions_command = "<C-n>"
"let g:jedi#popup_on_dot=0
let g:jedi#rename_command= "<leader>R"
"vim-flake8
"To add builtins, in your .vimrc:
"let g:flake8_builtins="_,apply"
"To ignore errors, in your .vimrc:
let g:flake8_ignore="E501,E401"
"If you want to change the max line length for PEP8:
let g:flake8_max_line_length=99
"To set the maximum McCabe complexity before a warning is issued:
let g:flake8_max_complexity=10
"To customize the location of your flake8 binary, set g:flake8_cmd:
"let g:flake8_cmd="/opt/strangebin/flake8000"
"To customize the location of quick fix window, set g:flake8_quickfix_location:
"let g:flake8_quickfix_location="topleft"
autocmd BufWritePost *.py call Flake8()
