#!/bin/bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

installnodemac() { \
  brew install node
}

installnodeubuntu() { \
  sudo apt install nodejs
  sudo apt install npm
}

installnodearch() { \
  sudo pacman -S nodejs
  sudo pacman -S npm
}

installnode() { \
  echo "Installing node..."
  [ "$(uname)" == "Darwin" ] && installnodemac
  [  -n "$(uname -a | grep Ubuntu)" ] && installnodeubuntu
  [ -f "/etc/arch-release" ] && installnodearch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
  sudo npm i -g neovim
}

installpiponmac() { \
  sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py
  rm get-pip.py
}

installpiponubuntu() { \
  if which pip > /dev/null; then
    echo "pip is already installed."
  else
    echo "Installing pip..."
    curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
    sudo python2 get-pip.py
    rm get-pip.py
    pip install --user jedi
    pip install --user pep8
  fi

  if which pip3 > /dev/null; then
    echo "pip3 is already installed."
  else
    echo "Installing pip3..."
    sudo apt-get install python3-pip -y
    sudo pip3 install -U jedi
    sudo pip3 install black
    sudo pip3 install isort
    sudo pip3 install ueberzug
    sudo pip3 install neovim-remote
  fi
}

installpiponarch() { \
  pacman -S python-pip
}

installpip() { \
  echo "Installing pip..."
  [ "$(uname)" == "Darwin" ] && installpiponmac
  [  -n "$(uname -a | grep Ubuntu)" ] && installpiponubuntu
  [ -f "/etc/arch-release" ] && installpiponarch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
}

installpynvim() { \
  echo "Installing pynvim..."
  pip3 install pynvim
}

installfots() { \
  echo "Installing fonts..."

  [ -d "$HOME/.fonts" ] && echo "fonts folder exists..." || mkdir -p $HOME/.fonts
  cp $HOME/.config/nvim/fonts/* $HOME/.fonts
}

installcocextensions() { \
  # Install extensions
  mkdir -p ~/.config/coc/extensions
  cd ~/.config/coc/extensions
  [ ! -f package.json ] && echo '{"dependencies":{}}'> package.json
  # Change extension names to the extensions you need
  sudo npm install coc-explorer coc-snippets coc-json coc-actions coc-xml coc-html coc-css coc-tsserver coc-docker coc-gocode coc-python coc-rls coc-vimtex coc-vimlsp coc-sh coc-angular coc-tslint coc-eslint coc-stylelint coc-diagnostic coc-syntax coc-dictionary coc-lists coc-tag coc-svg coc-emoji coc-github coc-calc coc-emmet coc-prettier coc-yank --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
  cd $HOME/.config/coc/ && ln -s $HOME/.config/nvim/coc-settings.json . && cd -
}

cloneconfig() { \
  echo "Cloning Nvim DevHerles configuration"
  git clone https://github.com/DevHerles/nvim.git ~/.config/nvim
}

moveoldnvim() { \
  echo "Moving your config to nvim.old"
  mv $HOME/.config/nvim $HOME/.config/nvim.old
}

installplugins() { \
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.tmp
  mv $HOME/.config/nvim/utils/init.vim $HOME/.config/nvim/init.vim
  echo "Installing plugins..."
  nvim --headless +PlugInstall +qall > /dev/null 2>&1
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/utils/init.vim
  mv $HOME/.config/nvim/init.vim.tmp $HOME/.config/nvim/init.vim
}

asktoinstallnode() { \
  echo "node not found"
  echo -n "Would you like to install node now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && installnode && installcocextensions
}

asktoinstallpip() { \
  # echo "pip not found"
  # echo -n "Would you like to install pip now (y/n)? "
  # read answer
  # [ "$answer" != "${answer#[Yy]}" ] && installpip
  echo "Please install pip3 before continuing with install"
  exit
}

installonmac() { \
  brew install ripgrep fzf ranger
}

pipinstallueberzug() { \
  which pip3 > /dev/null && pip3 install ueberzug || echo "Not installing ueberzug pip not found"
}

installonubuntu() { \
  sudo apt install ripgrep fzf ranger
  sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
  pip3 install ueberzug
  pip3 install neovim-remote
}


installonarch() { \
  sudo pacman -S install ripgrep fzf ranger
  which yay > /dev/null && yay -S python-ueberzug-git || pipinstallueberzug
  pip3 install neovim-remote
}

installextrapackages() { \
  [ "$(uname)" == "Darwin" ] && installonmac
  [  -n "$(uname -a | grep Ubuntu)" ] && installonubuntu
  [ -f "/etc/arch-release" ] && installonarch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
}

# Welcome
echo 'Installing Nvim DevHerles'

# install pip
which pip3 > /dev/null && echo "pip installed, moving on..." || asktoinstallpip

# install node and neovim support
which node > /dev/null && echo "node installed, moving on..." || asktoinstallnode


# install pynvim
pip3 list | grep pynvim > /dev/null && echo "pynvim installed, moving on..." || installpynvim

# move old nvim directory if it exists
[ -d "$HOME/.config/nvim" ] && moveoldnvim

# create undodir path
[ -d "$HOME/.tmp/undodir" ] && "undodir exists..." || mkdir -p $HOME/.tmp/undodir

# clone config down
cloneconfig

# install plugins
which nvim > /dev/null && installplugins

installcocextensions

installfots

echo "I recommend you add 'set preview_images_method ueberzug' to ~/.config/ranger/rc.conf"
