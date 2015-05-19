#!/bin/bash
shopt -s extglob
cd $HOME
#if ! [ -d .oh-my-zsh ]; then
#  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
#fi

function git_clone()
{
  GITHUB_USER=${$1%/*}
  GIT_REPO=${1#/*}
  TARGET_DIR=$2
  if [ -z $TARGET_DIR ]; then
    $TARGET_DIR = $GIT_REPO
  fi
  if command -v git; then
    git clone --recursive https://github.com/${GITHUB_USER}/${GIT_REPO}.git $TARGET_DIR
  else
    echo "Missing git, download master archive of $GIT_REPO"
    if [ -d $TARGET_DIR ]; then
      mkdir $TARGET_DIR
    fi
    DEST_FILE=$TARGET_DIR/$GIT_REPO.tar.gz
    wget -O $DEST_FILE https://github.com/${GITHUB_USER}/${GIT_REPO}/archive/master.tar.gz
    tar $DEST_FILE xf -C $TARGET_DIR/ --strip-components 1
  fi
}

# ZSH Framework
if ! [ -d .zprezto ]; then
  git_clone prezto .zprezto
fi
for rcfile in "$HOME"/.zprezto/runcoms/!(README.md); do
  dotfile="$HOME/.$(basename ${rcfile})"
  if [ -e $dotfile ]; then
    echo "[WARN] $dotfile exists, skipping $rcfile"
    continue
  fi
  ln -sv $rcfile $dotfile
done

for file in vim bash_profile bashrc pentadactylrc gtkrc-2.0 gtkrc-solarized vimrc Xdefaults xpdfrc tmux.conf; do
  dotfile="$PWD/.$file"
  src="system/.$file"
  if [ -e "$dotfile" ]; then
    echo "Skipping $src"
  else
    echo "$src --> $dotfile"
    ln -s $src $dotfile
  fi
done

infocmp rxvt-unicode-256color 2>&1 > /dev/null || {
  [ -d ~/.terminfo ] || mkdir ~/.terminfo
  tic -o ~/.terminfo system/rxvt-unicode-256color.terminfo
}
[ -d ~/tools/dircolors-solarized ] || {
  git_clone dircolors-solarized ~/tools/dircolors-solarized
}
rm -vf ~/.dircolors
ln -sv ~/tools/dircolors-solarized/dircolors.256dark ~/.dircolors

if [ -e ".ssh/config" ]; then
  echo "SSH Config exists, skipping..."
else
  if ! [ -d ~/.ssh ]; then
    echo "Creating ~/.ssh ..."
    mkdir ~/.ssh
  fi
  ln -sv system/ssh_config .ssh/config
fi

[ -x $HOME/tools/bin/fasd ] || {
  echo "Installing fasd ..."
  [ -d $HOME/tools/fasd ] || git_clone clvv/fasd $HOME/tools/fasd
  cd  $HOME/tools/fasd
  make PREFIX=$HOME/tools install
}

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
echo "Using a custom ssh command. configuration files are combined by pattern config.*"
[ -e $TOOLS_BIN/ssh ] || ln -sv $HOME/system/ssh $TOOLS_BIN/ssh

VUNDLE="$HOME/tools/vim-plugins/Vundle.vim"
if ! [ -d $VUNDLE ]; then
  git_clone gmarik/Vundle $VUNDLE
fi

[ -d ~/.config ] || mkdir ~/.config
AWESOME_DIR="system/awesome"
echo "Awesome Configuration"
[ -L ~/.config/awesome ] || ln -sv ../$AWESOME_DIR ~/.config/

