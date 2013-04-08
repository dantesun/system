#!/usr/local/bin/bash
# .bashrc

# Make Bash append rather than overwrite the history on disk
shopt -s histappend
export CDPATH=".:..:../..:~:~/fusion.main/fusion/components/services"

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

export P4EDITOR=vim
export P4CONFIG=.p4config
export P4USER=dsun
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

function p4() 
{
  local P4="/usr/local/bin/p4"
  local VOB_ROOT=`/home/tools/public/bin/getRoot.sh`
  if [ ! $? = 0 ]; then
    echo "$VOB_ROOT"
    return 1
  fi
  local P4_CLIENT=`cat $VOB_ROOT/.p4client`
  if [ ! $? = 0 ]; then
    echo "$P4CLIENT"
    return 1
  fi
  P4CLIENT="$P4_CLIENT" $P4 $*
}
export -f p4
