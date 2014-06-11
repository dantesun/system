#!/bin/sh
cd $HOME
for file in oh-my-zsh vim dircolors gtkrc-2.0 gtkrc-solarized vimrc Xdefaults xpdfrc zshrc; do
  dotfile="$PWD/.$file"
  src="system/.$file"
  if [ -e "$dotfile" ]; then
    echo "Skipping $src"
  else
    echo "$src --> $dotfile"
    ln -s $src $dotfile
  fi
done

for d in backup swap; do
  vimrun=".vimruntime/$d"
  if ! [ -d $vimrun ]; then
    echo "Creating directory $vimrun"
    mkdir -p $vimrun
  else
    echo "$vimrun exists."
  fi
done
