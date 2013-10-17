#!/bin/bash
# .bashrc

# Make Bash append rather than overwrite the history on disk
shopt -s histappend
export CDPATH=".:..:../..:~:~/fusion.tsoft/fusion/components/services"

#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dsun.awt.disablegrab=true' 
TOOL_PATH=$HOME/tools/bin:$HOME/tools/sbin
if [ "Darwin" = `uname -s` ]; then
  # This is for HomeBrew on MacOS
  if which brew &> /dev/null; then
#    PHP_PATH="$(brew --prefix php54)/bin"
    CURL_PATH="$(brew --prefix curl)/bin"
    COREUTIL_PATH="$(brew --prefix coreutils)/libexec/gnubin"
    FINDUTILS_PATH="$(brew --prefix findutils)/bin"
    CTAGS_PATH="$(brew --prefix ctags)/bin"
    GETTEXT_PATH="$(brew --prefix gettext)/bin"
    BREW_AUX_PATH="$COREUTIL_PATH:$CURL_PATH:$PHP_PATH:$FINDUTILS_PATH:$CTAGS_PATH:$GETTEXT_PATH"
    alias find=gfind
  fi
  #Note: on MacOS /etc/paths will make /usr/local/bin the last element in PATH, must explicitly append /usr/local/bin before PATH
  export PATH=/usr/local/bin:$BREW_AUX_PATH:$TOOL_PATH:$PATH
else
  export PATH=$TOOL_PATH:$PATH
fi

unset MANPATH
export MANPATH=$HOME/tools/share/man:$(manpath)

# User specific aliases and functions
alias vi='vim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cp='cp -i'
alias rm='rm -i'
alias tmux='tmux -2'

[[ -f $HOME/.bash_functions ]] && . $HOME/.bash_functions

#Solarized Theme
[[ -f $HOME/.dircolors ]] && eval `dircolors $HOME/.dircolors`

#Fix the Java AWT problem
if which wmname &> /dev/null; then
  [[ -z $DISPLAY ]] || wmname LG3D
fi

# A file for customization of environment
[[ -f "$HOME/.bash_custom" ]] && source  "$HOME/.bash_custom"

