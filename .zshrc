# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
DISABLE_AUTO_UPDATE=true
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
# ZSH_THEME="cloud"
# ZSH_THEME="agnoster"
ZSH_THEME="powerline"
POWERLINE_RIGHT_B=""
POWERLINE_RIGHT_A="exit-status"
POWERLINE_DETECT_SSH="true"
POWERLINE_NO_BLANK_LINE="true"

TOOL_PATH=$HOME/tools/bin:$HOME/tools/sbin
if [ "Darwin" = `uname -s` ]; then
  #Note: on MacOS /etc/paths will make /usr/local/bin the last element in PATH, must explicitly append /usr/local/bin before PATH
  export PATH=/usr/local/bin:$PATH
  # This is for HomeBrew on MacOS
  if which brew &> /dev/null; then
    CURL_PATH="$(brew --prefix curl)/bin"
    COREUTIL_PATH="$(brew --prefix coreutils)/libexec/gnubin"
    FINDUTILS_PATH="$(brew --prefix findutils)/bin"
    CTAGS_PATH="$(brew --prefix ctags)/bin"
    GETTEXT_PATH="$(brew --prefix gettext)/bin"
    BREW_AUX_PATH="$COREUTIL_PATH:$CURL_PATH:$FINDUTILS_PATH:$CTAGS_PATH:$GETTEXT_PATH"
    alias find=gfind
  fi
  export PATH=$BREW_AUX_PATH:$TOOL_PATH:$PATH
else
  export PATH=$TOOL_PATH:$PATH
fi

unset MANPATH
export MANPATH=$HOME/tools/share/man:$(manpath)

# User specific aliases and functions
alias vi='vim'
# export TERM='xterm-256color'
if [ -f ~/.dircolors ]; then
  eval $(dircolors ~/.dircolors)
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(git git-flow git-extras cp colored-man common-aliases \
#          fastfile gem sudo tmux vi-mode virtualenv wd z zsh-syntax-highlighting)
plugins=(cp colored-man common-aliases \
         gem sudo tmux vi-mode virtualenv \
         wd z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Fix some keys I need in VI mode
bindkey "^R" history-incremental-search-backward
bindkey '\e.' insert-last-word
# User configuration

if [ -f $HOME/.zsh_local ]; then
  source $HOME/.zsh_local
fi
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


[ -f ~/.ssh/config.host ] && : ${(A)ssh_config_hosts:=${${${${(@M)${(f)"$(<~/.ssh/config.host)"}:#Host *}#Host }:#*\**}:#*\?*}}
[ -f ~/.ssh/known_hosts ] && : ${(A)ssh_known_hosts:=${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*}}
zstyle ':completion:*:hosts' hosts $ssh_config_hosts $ssh_known_hosts

