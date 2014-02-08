if [ -e $HOME/tools/bin/zsh ]; then
  exec $HOME/tools/bin/zsh -l
elif [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

