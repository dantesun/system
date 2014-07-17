#!/bin/sh
cd $HOME
if ! [ -d .oh-my-zsh ]; then
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

for file in vim bash_profile bashrc pentadactylrc dircolors gtkrc-2.0 gtkrc-solarized vimrc Xdefaults xpdfrc zshrc; do
  dotfile="$PWD/.$file"
  src="system/.$file"
  if [ -e "$dotfile" ]; then
    echo "Skipping $src"
  else
    echo "$src --> $dotfile"
    ln -s $src $dotfile
  fi
done

if [ -e ".ssh/config" ]; then
  echo "SSH Config exists, skipping..."
else
  ln -sv system/ssh_config .ssh/config
fi

for d in backup swap; do
  vimrun=".vimruntime/$d"
  if ! [ -d $vimrun ]; then
    echo "Creating directory $vimrun"
    mkdir -p $vimrun
  else
    echo "$vimrun exists."
  fi
done

TOOLS_BIN=$HOME/tools/bin
[ -d  $TOOLS_BIN ] || mkdir -p $TOOLS_BIN
[ -d  ~/tmp ] || mkdir -p ~/tmp
[ -e $TOOLS_BIN/ssh ] || ln -sv $HOME/system/ssh $TOOLS_BIN/ssh

VUNDLE="$HOME/tools/vim-plugins/Vundle.vim"
if ! [ -d $VUNDLE ]; then
  git clone https://github.com/gmarik/Vundle.vim $VUNDLE
fi
