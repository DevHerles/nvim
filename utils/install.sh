#!/bin/bash

set -o nounset # -------------------- error when referencing undefined variable
set -o errexit # -------------------------------------- exit when command fails

function installpip() { \
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
    sudo pip3 install jedi black isort ueberzug neovim-remote pynvim
  fi
}

function installAdminTools() {
  echo "Installing admin tools"

  # install lazydocker, ripgrep, fzf, universal-ctags, silversearcher-ag, fd-find...
  which xclip > /dev/null && echo "xclip is already installed." || sudo apt-get install xclip
  which xsel > /dev/null && echo "xsel is already installed." || sudo apt-get install xsel
  which htop > /dev/null && echo "htop is already installed." || sudo apt-get install htop
  which ranger > /dev/null && echo "ranger is already installed." || sudo apt-get install ranger libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
  which netstat > /dev/null && echo "net-tools are already installed." || sudo apt-get install net-tools
  which ctags > /dev/null && echo "ctags is already installed." || sudo apt-get install ctags
  which ruby > /dev/null && echo "ruby is already installed." || sudo apt-get install ruby-full
  which lazygit > /dev/null && echo "lazygit is already installed." || sudo add-apt-repository ppa:lazygit-team/release && sudo apt-get update && sudo apt-get install lazygit
  which lazydocker > /dev/null && echo "lazydocker is already installed." || askToInstallLazyDocker
  which ripgrep > /dev/null && echo "ripgrep is already installed." || sudo apt install ripgrep -y
  which universal-ctags > /dev/null && echo "universal-ctags is already installed." || sudo apt install universal-ctags -y
  which silversearcher-ag > /dev/null && echo "silversearcher-ag is already installed." || sudo apt install silversearcher-ag -y
  which fd-find > /dev/null && echo "fd-find is already installed." || sudo apt install fd-find -y
  which neofetch > /dev/null && echo "neofetch is already installed." || sudo apt install neofetch -y
  which clang-format > /dev/null && echo "clang-format is already installed." || sudo apt-get install clang-format -y
  which tree > /dev/null && echo "tree is already installed." || sudo apt install tree -y
  which pip3 > /dev/null && echo "pip3 is already installed." || installpip

  if which npm > /dev/null; then
    echo "npm is already installed."
  else
    echo "Installing npm..."
    sudo apt install npm -y
    sudo npm install -g neovim js-beautify vtop eslint prettier eslint-config-prettier eslint-plugin-prettier
  fi

  which node > /dev/null && echo "nodejs is already installed." || sudo apt install nodejs

  if [ -f /usr/bin/dfc ]; then
    echo "dfc is already installed"
  else
    echo "Installing dfc..."
    sudo apt-get install dfc
  fi

  if [ -f /usr/bin/vivid ]; then
    echo "vivid is already installed"
  else
    echo "Downloading vivid0.4.0..."
    wget "https://github.com/sharkdp/vivid/releases/download/v0.4.0/vivid_0.4.0_amd64.deb"
    echo "Installing vivid0.4.0..."
    sudo dpkg -i vivid_0.4.0_amd64.deb
  fi

  export LS_COLORS="$(vivid generate snazzy)"
}

function installPostgresql() {
  which psql > /dev/null && echo "postgresql is already installed." || sudo apt install postgresql postgresql-contrib -y
}

function installFlutter() {
  if which flutter > /dev/null; then
    echo "flutter is already installed."
  else
    if [ -d ~/.flutter ]; then
      echo "flutter is already installed.."
    else
      echo "Installing flutter..."
      git clone https://github.com/flutter/flutter.git -b stable --depth 1 $HOME/.flutter
      echo 'export PATH=$PATH:~/.flutter/bin' >> ~/.bashrc
    fi
  fi
  source ~/.bashrc

  if which adb > /dev/null; then
    echo "adb are already installed."
  else
    echo "Installing adb..."
    sudo apt-get install adb -y
    sudo usermod -aG plugdev $LOGNAME
  fi
}

function installOhMyZSH() {
  echo "Installing ZSH y git-core..."

  cd ~/
  which zsh > /dev/null && echo "zsh is already installed." || sudo apt-get install zsh
  which git > /dev/null && echo "Git is already installed." || sudo apt-get install git-core

  if [ -d ~/.oh-my-zsh ]; then
    if [ -f ~/.oh-my-zsh/themes/asf.zsh-theme ]; then
      rm ~/.oh-my-zsh/themes/asf.zsh-theme
    fi
    cd ~/.oh-my-zsh && git pull;
  else
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
  fi

  if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    cd ~/.oh-my-zsh && git pull;
  else
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  fi

  if [ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
    cd ~/.oh-my-zsh && git pull;
  else
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
  fi

  if [ -f ~/.zshrc ]; then
    rm ~/.zshrc
  fi

  if [ $SHELL == "/usr/bin/zsh" ]; then
    echo "Skipping, your current console is already zsh..."
  else
    echo "Changing console to zsh..."
    chsh -s `which zsh`
  fi
}

function installLazyDocker() {
  echo "Installing lazydocker..."
  wget https://github.com/jesseduffield/lazydocker/releases/download/v0.9/lazydocker_0.9_Linux_x86_64.tar.gz
  tar xvzf lazydocker*.tar.gz
  sudo install lazydocker /usr/local/bin
  rm lazydocker*
  rm -rf lazydocker
}

function askToInstallLazyDocker() {
  echo -n "Would you like to install lazydocker now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && installLazyDocker
}

function installDocker() {
  if which docker > /dev/null; then
    echo "Docker is already installed."
  else
    echo "Installing docker..."
    sudo apt install docker.io
    sudo systemctl start docker
    sudo systemctl enable docker

    if [ $(getent group docker) ]; then
      echo "docker group exists."
    else
      sudo groupadd docker
    fi
    sudo usermod -aG docker $USER
    newgrp docker
    which lazydocker > /dev/null && "lazydocker is already installed" || askToInstallLazyDocker
  fi
  which docker-compose > /dev/null && echo "docker-compose is already installed." || sudo apt install docker-compose -y
}

function installTmux() {
  which tmux > /dev/null && echo "tmux is already installed." || sudo apt install tmux -y
  echo "Installing tmux plugin manager..."
  if [ -d ~/.tmux/plugins/tpm ]; then
    cd ~/.tmux/plugins/tpm && git pull
  else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

function moveOldNvim() { \
  echo "Moving your config to nvim.old"
  mv $HOME/.config/nvim $HOME/.config/nvim.old
}

function cloneNvimConfig() { \
  [ -d "$HOME/.config/nvim" ] && moveOldNvim || echo "No previous nvim..."
  echo "Cloning Nvim DevHerles configuration"
  which nvim > /dev/null && echo "nvim is already installed..." || sudo apt install neovim -y
  git clone https://github.com/DevHerles/nvim.git ~/.config/nvim
}

function installNvimPlugins() { \
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.tmp
  mv $HOME/.config/nvim/utils/init.vim $HOME/.config/nvim/init.vim
  echo "Installing plugins..."
  nvim --headless +PlugInstall +qall > /dev/null 2>&1
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/utils/init.vim
  mv $HOME/.config/nvim/init.vim.tmp $HOME/.config/nvim/init.vim

  # create undodir path
  [ -d "$HOME/.tmp/undodir" ] && "undodir exists..." || mkdir -p $HOME/.tmp/undodir

}

function installCocExtensions() { \
  # Install extensions
  mkdir -p ~/.config/coc/extensions
  cd ~/.config/coc/extensions
  [ ! -f package.json ] && echo '{"dependencies":{}}'> package.json
  # Change extension names to the extensions you need
  sudo npm install coc-explorer coc-snippets coc-json coc-actions coc-xml coc-html coc-css coc-tsserver coc-docker coc-gocode coc-python coc-rls coc-vimtex coc-vimlsp coc-sh coc-angular coc-tslint coc-eslint coc-stylelint coc-diagnostic coc-syntax coc-dictionary coc-lists coc-tag coc-svg coc-emoji coc-github coc-calc coc-emmet coc-prettier coc-yank --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
  cd $HOME/.config/coc/ && ln -sf $HOME/.config/nvim/coc-settings.json . && cd -
}

function linkDotFiles() {
  cd ~/

  echo "Linking asf.zsh-theme..."
  ln -sf ~/.config/nvim/oh-my-zsh/themes/asf.zsh-theme ~/.oh-my-zsh/themes/asf.zsh-theme

  echo "Linking .gitconfig..."
  ln -sf ~/.config/nvim/dotfiles/gitconfig ~/.gitconfig

  echo "Linking .tmux.conf..."
  ln -sf ~/.config/nvim/dotfiles/tmux.conf ~/.tmux.conf

  echo "Linking .zshrc..."
  ln -sf ~/.config/nvim/dotfiles/zshrc ~/.zshrc

}

function setupDirColors() {
  echo "Setup dircolors..."
  eval $( dircolors -b ~/.config/nvim/dir_colors )
}

function installFonts() { \
  echo "Installing fonts..."
  [ -d "$HOME/.fonts" ] && echo "fonts folder already exists..." || mkdir -p $HOME/.fonts
  cp $HOME/.config/nvim/fonts/* $HOME/.fonts
}

function install() {
  echo 'Installing Nvim DevHerles'
  installAdminTools
  installPostgresql
  installFlutter
  installOhMyZSH
  installDocker
  installTmux
  cloneNvimConfig
  installNvimPlugins
  installCocExtensions
  linkDotFiles
  setupDirColors
  installFonts
  echo "I recommend you add 'set preview_images_method ueberzug' to ~/.config/ranger/rc.conf"
}

install

