#!/usr/local/bin/bash
# .bashrc

# Make Bash append rather than overwrite the history on disk
shopt -s histappend
export CDPATH=".:..:../..:~:~/fusion.main/fusion/components/services"

#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dsun.awt.disablegrab=true' 
export PATH=$HOME/tools/bin:$HOME/tools/sbin:$PATH
if [ "Darwin" = `uname -s` ]; then
  if which brew &> /dev/null; then
    PHP_PATH="$(brew --prefix php54)/bin"
    CURL_PATH="$(brew --prefix curl)/bin"
    COREUTIL_PATH="$(brew --prefix coreutils)/libexec/gnubin"
    FINDUTILS_PATH="$(brew --prefix findutils)/bin"
    CTAGS_PATH="$(brew --prefix ctags)/bin"
    GETTEXT_PATH="$(brew --prefix gettext)/bin"
    export PATH=$COREUTIL_PATH:$CURL_PATH:$PHP_PATH:$FINDUTILS_PATH:$CTAGS_PATH:$GETTEXT_PATH:$PATH
    alias find=gfind
  fi
fi
export P4EDITOR=vim
export P4CONFIG=.p4config
export EDITOR=vim
export DEV_SITE=china
unset MANPATH
export MANPATH=$HOME/tools/share/man:$(manpath)

# User specific aliases and functions
alias vi='vim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cp='cp -i'
alias rm='rm -i'
alias tmux='tmux -2'

[[ -f .bash_functions ]] && . .bash_functions

#Solarized Theme
[[ -f $HOME/.dircolors ]] && eval `dircolors $HOME/.dircolors`

alias systray='trayer --expand true --widthtype request --transparent true --alpha 255 --edge top --align right --SetDockType false'
alias rdesktop='rdesktop -z -u dsun -d bytemobile.com'

#Fix the Java AWT problem
if which wmname &> /dev/null; then
  [[ -z $DISPLAY ]] || wmname LG3D
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
