#!/bin/bash

# Helper functions.
function notice { echo -e "\033[1;32m=> $1\033[0m"; }
function error { echo -e "\033[1;31m=> Error: $1\033[0m"; }

# Install dependencies.
yes | sudo apt-get install build-essential git-core curl

# Install ruby
curl -L get.rvm.io | bash -s stable
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
. ~/.bashrc
rvm install 1.9.3
rvm use 1.9.3
rvm --default use 1.9.3
yes | gem install bundler

# Copy original .bashrc to .bashrc.local.
if [ -f ~/.bashrc ] && [ ! -f ~/.bashrc.local ]; then
    cp ~/.bashrc ~/.bashrc.local
fi

# Are we updating or installing?
if [ -d ~/.dotfiles ]; then
  notice "Updating..."
  cd ~/.dotfiles
  git pull origin master
  git submodule init
  git submodule update

  notice "Installing..."
  bundle update
  bundle exec rake install
else
  notice "Downloading..."
  git clone --recursive git@github.com:robingustafsson/dotfiles.git ~/.dotfiles

  notice "Installing..."
  cd ~/.dotfiles
  bundle update
  bundle exec rake install
fi

# Finished.
cd $current_pwd
notice "Done"

# Source dotfiles.
if [ -f ~/.bashrc ] ; then
    source ~/.bashrc
fi
