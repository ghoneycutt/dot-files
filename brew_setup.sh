#!/bin/bash

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# nerd fonts
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# apg
brew tap jzaleski/homebrew-jzaleski
brew install apg

brew install bash-completion
brew install brew-cask-completion
brew install bundler-completion
brew install cask
brew install colordiff
brew install coreutils
brew install cowsay
brew install curl
brew install direnv
brew install git
brew install gnupg
brew install jq
brew install nmap
brew install pssh
brew install telnet
brew install tree
brew install vim
brew install watch
brew install wget
