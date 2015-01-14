set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/tools/vim-plugins/Vundle.vim
" call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/tools/vim-plugins')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'

Plugin 'majutsushi/tagbar'

Plugin 'tpope/vim-surround' "Surround plugin

Plugin 'kien/ctrlp.vim'

Plugin 'ervandew/supertab'

Plugin 'vim-scripts/OmniCppComplete'

Plugin 'tpope/vim-ragtag'

Plugin 'mileszs/ack.vim'

Plugin 'vim-scripts/EnhCommentify.vim'

Plugin 'jeetsukumaran/vim-buffergator'

Plugin 'vim-scripts/autoload_cscope.vim'

Plugin 'bling/vim-airline' "VIM status line

Plugin 'tpope/vim-fugitive' "Git integration

Plugin 'davidhalter/jedi-vim' "Python Autocompletion

Plugin 'nvie/vim-flake8' "Python syntax check

Plugin 'dantesun/vim-python-pep8-indent' 

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on
