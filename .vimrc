set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'scrooloose/nerdtree'

Plugin 'majutsushi/tagbar'

Plugin 'kien/ctrlp.vim'

Plugin 'ervandew/supertab'

Plugin 'vim-scripts/OmniCppComplete'

Plugin 'vim-scripts/ag.vim'

Plugin 'tpope/vim-ragtag'

" All of your Plugins must be added before the following line
call vundle#end()            " required
